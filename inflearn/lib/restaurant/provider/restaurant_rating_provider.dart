import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/model/cursor_pagination_model.dart';
import 'package:inflearn/common/provider/pagination_provider.dart';
import 'package:inflearn/rating/model/rating_model.dart';
import 'package:inflearn/restaurant/repository/restaurant_repository.dart';

import '../repository/restaurant_rating_repository.dart';


final restuarantRatingProvider = StateNotifierProvider.family<RestaurantRatingStateNotifier,CursorPaginationBase,String>
  ((ref,id) {
    final repo = ref.watch(restuarantRatingRepositoryProvider(id));
    return RestaurantRatingStateNotifier(repository: repo);

});

class RestaurantRatingStateNotifier extends PaginationProvider<RatingModel,RestuarantRatingRepository>{

  RestaurantRatingStateNotifier({required super.repository});

}