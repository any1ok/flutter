import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/dio/dio.dart';
import 'package:inflearn/common/utils/pagination_utils.dart';
import 'package:inflearn/restaurant/component/restaurant_card.dart';
import 'package:inflearn/restaurant/model/restaurant_model.dart';
import 'package:inflearn/restaurant/provider/restuarant_provider.dart';
import 'package:inflearn/restaurant/view/restaurant_detail_screen.dart';

import '../../common/component/paginaiton_list_view.dart';
import '../../common/const/data.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../repository/restaurant_repository.dart';

// class RestaurantScreen extends ConsumerStatefulWidget {
//   const RestaurantScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
// }

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return PaginationListView(
        provider: restaurantProvider,
      itemBuilder: <RestaurantModel>( _,  index, model) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => RestaurantDetailScreen(
                  id: model.id,
                ))
            );
          },
          child: RestaurantCard.fromModel(
            model : model,
          ),
        );
      },

    );


  }
}
