import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:denemefirebaseauth/product/enum/view_state.dart';
import 'package:denemefirebaseauth/screens/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/large_text.dart';
import '../../../init/theme/colors.dart';
import '../../../product/components/custom_circular_progress_indicator.dart';
import '../../../product/components/not_connected_network.dart';
import '../../../product/components/profile_picture_and_menu.dart';
import '../../homepage/view/details_page_view.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return viewModel.state == ViewState.idle
        ? Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfilePictureAndMenuIcon(),
                _buildTextFavorite(),
                viewModel.favoriteList.isNotEmpty
                    ? _buildListPlace(viewModel)
                    : Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomLargeText(text: "Favorilerim Boş")
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          )
        : viewModel.state == ViewState.busy
            ? const CustomCircular()
            : const NotConnectedNetwork();
  }

  Container _buildTextFavorite() {
    return Container(
        margin: context.paddingLeft,
        child: CustomLargeText(text: "Favorilerim"));
  }

  Expanded _buildListPlace(HomeViewModel viewModel) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: viewModel.favoriteList.length,
        itemBuilder: (BuildContext context, int index) {
          int id = viewModel.favoriteList[index].placeId! - 1;
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<HomeViewModel>.value(
                      value: viewModel,
                      child: DetailPageView(index: id),
                    ),
                  ));
                },
                child: Container(
                  padding: context.paddingFavorite,
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30), // Image radius
                      child: Stack(
                        children: [
                          _buildImage(viewModel, index),
                          Container(color: Colors.black.withOpacity(0.5)),
                          _buildOnImageWidget(viewModel, index, id),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Padding _buildOnImageWidget(HomeViewModel viewModel, int index, int id) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: CustomLargeText(
              text: viewModel.favoriteList[index].name ?? "",
              color: Colors.white,
              size: 30,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLargeText(
                    text: viewModel.favoriteList[index].price.toString(),
                    color: Colors.white,
                    size: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                              5,
                              (count) {
                                return Icon(
                                  count < viewModel.placeList![index].stars!
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: CustomColor.starColor,
                                );
                              },
                            ),
                          ),
                          CustomLargeText(
                            text:
                                "(${viewModel.favoriteList[index].stars.toString()}.0)",
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (viewModel.placeList![id].isFavorite == false) {
                    viewModel.addFavorite(id);
                  } else {
                    viewModel.removeFavorite(id);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: viewModel.placeList![id].isFavorite!
                          ? CustomColor.mainColor
                          : CustomColor.buttonBackground),
                  child: viewModel.placeList![id].isFavorite!
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : const Icon(Icons.favorite_outline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Positioned _buildImage(HomeViewModel viewModel, int index) {
    return Positioned.fill(
      child: Image.network(
        viewModel.favoriteList[index].image ?? "",
        fit: BoxFit.fill,
      ),
    );
  }
}
