import 'package:denemefirebaseauth/core/components/large_text.dart';
import 'package:denemefirebaseauth/init/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/components/profile_picture_and_menu.dart';
import '../../home/viewmodel/home_viewmodel.dart';
import '../../homepage/view/details_page_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfilePictureAndMenuIcon(),
          buildSearch(viewModel),
          Expanded(
            child: _searchController.text.isNotEmpty &&
                    viewModel.searchList.isEmpty
                ? const Center(child: CustomLargeText(text: "Sonuç yok"))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: viewModel.searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      int id = viewModel.searchList[index].placeId! - 1;
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
                              padding: const EdgeInsets.only(
                                  right: 15, top: 10, left: 15),
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10), // Image border
                                child: SizedBox.fromSize(
                                  size:
                                      const Size.fromRadius(30), // Image radius
                                  child: Stack(
                                    children: [
                                      _buildImage(viewModel, index),
                                      Container(
                                          color: Colors.black.withOpacity(0.5)),
                                      _buildOnImageWidget(viewModel, index, id),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Padding _buildOnImageWidget(HomeViewModel viewModel, int index, int id) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: CustomLargeText(
              text: viewModel.searchList[index].name ?? "",
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
                    text: viewModel.searchList[index].price.toString(),
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
                                "(${viewModel.searchList[index].stars.toString()}.0)",
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
                  if (viewModel.searchList[index].isFavorite == false) {
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
                      color: viewModel.searchList[index].isFavorite!
                          ? CustomColor.mainColor
                          : CustomColor.buttonBackground),
                  child: viewModel.searchList[index].isFavorite!
                      ? const Icon(Icons.favorite, color: Colors.white)
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
        viewModel.searchList[index].image ?? "",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildSearch(HomeViewModel viewModel) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            viewModel.searchListItem(value);
          },
          controller: _searchController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: CustomColor.mainColor),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15, right: 15, top: 15),
            hintText: 'Mekan Ara',
          ),
        ),
      );
}
