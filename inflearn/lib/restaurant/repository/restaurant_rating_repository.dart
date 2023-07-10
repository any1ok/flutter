import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/dio/dio.dart';
import 'package:inflearn/common/repository/base_pagination_repository.dart';
import 'package:inflearn/rating/model/rating_model.dart';
import 'package:inflearn/restaurant/repository/restaurant_repository.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';

part 'restaurant_rating_repository.g.dart';

final restuarantRatingRepositoryProvider = Provider.family<
RestuarantRatingRepository,String>((ref,id){
  final dio = ref.watch(dioProvider);
  return RestuarantRatingRepository(dio, baseUrl: 'http://$ip/restaurant/$id/rating');
});

@RestApi()
abstract class RestuarantRatingRepository implements IBasePaginationRepository<RatingModel>{
  factory RestuarantRatingRepository(Dio dio, {String baseUrl}) =
      _RestuarantRatingRepository;

  @GET('/')
  @Headers({
    'accessToken' : 'true',
  })
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}