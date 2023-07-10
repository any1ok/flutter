import 'package:retrofit/http.dart';

import '../../rating/model/rating_model.dart';
import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId>{
  Future<CursorPagination<T>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}