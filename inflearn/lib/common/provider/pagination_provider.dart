import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/model/cursor_pagination_model.dart';
import 'package:inflearn/common/model/model_with_id.dart';
import 'package:inflearn/common/repository/base_pagination_repository.dart';

import '../model/pagination_params.dart';



class PaginationProvider<T extends IModelWithId,
U extends IBasePaginationRepository<T>> extends StateNotifier<CursorPaginationBase>{
  final U repository;

  PaginationProvider({required this.repository}):
      super(CursorPaginationLoading()){
    paginate();
  }
  Future<void> paginate({
    int fetchCount = 20,
    //추가로 가져와라
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      //5가지 가능성
      // 1 CursorPagination - 정상적으로 데이터가 있는 상태
      // 2 CursorPaginationLoading - 데이터가 로딩중인 상태
      // 3 CursorpaginationError - 에러가 있는상태
      // 4 CursorPaginationRefetching - 첫번ㅂ째 페이지부터 다시 데이터를 가져올때
      // 5 CursorPaginationFetchMore - 추가 데이터를 pagination 해오라는 요청을 받았을때

      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchignMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchignMore)) {
        return;
      }

      // paginationParams 생셩
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );
      if (fetchMore) {
        final pState = state as CursorPagination<T>;
        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          state =
              CursorPaginationRefetching<T>(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }


      final resp = await repository.paginate(
          paginationParams: paginationParams
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        state = resp.copyWith(
            data: [
              ...pState.data,
              ...resp.data,
            ]
        );
      }
      else {
        state = resp;
      }
    } catch (e,stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터 가져오지 못했습니다');
    }
  }
}