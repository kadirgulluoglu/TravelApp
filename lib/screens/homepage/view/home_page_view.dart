import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemefirebaseauth/core/components/large_text.dart';
import 'package:denemefirebaseauth/core/extension/context_extensions.dart';
import 'package:denemefirebaseauth/product/components/custom_circular_progress_indicator.dart';
import 'package:denemefirebaseauth/product/enum/view_state.dart';
import 'package:denemefirebaseauth/screens/homepage/view/details_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/text.dart';
import '../../../init/theme/colors.dart';
import '../../../models/user_model.dart';
import '../../../product/components/circle_tab_indicator.dart';
import '../../../product/components/not_connected_network.dart';
import '../../../product/components/profile_picture_and_menu.dart';
import '../../home/viewmodel/home_viewmodel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel = UserModel();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getFirebase();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return viewModel.state == ViewState.idle
        ? Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfilePictureAndMenuIcon(),
                _buildTextDiscover(),
                SizedBox(height: context.height * .03),
                _buildTabBar(),
                _buildTabBarView(viewModel),
                SizedBox(height: context.height * .05),
                _buildDiscoverAllText(),
                SizedBox(height: context.height * .01),
                _buildDiscoverAllItem()
              ],
            ),
          )
        : viewModel.state == ViewState.busy
            ? const CustomCircular()
            : const NotConnectedNetwork();
  }

  Future getFirebase() async {
    await FirebaseFirestore.instance
        .collection("person")
        .doc(user!.uid)
        .get()
        .then((value) => {
              userModel = UserModel.fromMap(value.data()),
              setState(() {}),
            });
  }

  Map<String, String> image = {
    "balloning": "Balon Turu",
    "hiking": "Dağ Yürüyüşü",
    "snorkling": "Dalış",
    "kayaking": "Kayak",
  };

  Container _buildDiscoverAllItem() {
    return Container(
      height: 100,
      margin: context.paddingLeft,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: image.length,
          itemBuilder: (context, index) {
            return Container(
              margin: context.paddingRight,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(30), // Image radius
                        child: Image.asset(
                            'assets/images/${image.keys.elementAt(index)}.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  CustomText(
                    text: image.values.elementAt(index),
                  )
                ],
              ),
            );
          }),
    );
  }

  Padding _buildDiscoverAllText() {
    return Padding(
      padding: context.paddingHomePage,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomLargeText(text: "Daha fazlasını Keşfet", size: 22),
          CustomText(text: "Tümü", color: CustomColor.textColor1)
        ],
      ),
    );
  }

  Container _buildTabBarView(HomeViewModel viewModel) {
    return Container(
      padding: context.paddingLeft,
      height: 270,
      width: double.maxFinite,
      child: TabBarView(
        controller: _tabController,
        children: [
          buildListView(viewModel, 0),
          buildListView(viewModel, 1),
          buildListView(viewModel, 2),
        ],
      ),
    );
  }

  Align _buildTabBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        labelPadding: context.paddingNormalHorizontal,
        labelColor: Colors.black,
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        indicator:
            const CircleTabIndicator(radius: 4, color: CustomColor.mainColor),
        tabs: const [
          Tab(text: "Yerler"),
          Tab(text: "Seyahat"),
          Tab(text: "Diğerleri"),
        ],
      ),
    );
  }

  Container _buildTextDiscover() {
    return Container(
        margin: context.paddingLeft,
        child: CustomLargeText(text: "Merhaba\n${userModel?.name ?? ""}"));
  }

  ListView buildListView(HomeViewModel viewModel, int type) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: viewModel.placeList!.length,
      itemBuilder: (BuildContext context, int index) {
        return viewModel.placeList?[index].type == type
            ? InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<HomeViewModel>.value(
                      value: viewModel,
                      child: DetailPageView(
                        index: index,
                      ),
                    ),
                  ));
                },
                child: Container(
                  padding: context.paddingCard,
                  width: 205,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30), // Image radius
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Hero(
                              tag: viewModel.placeList?[index].image ?? "",
                              child: Image.network(
                                viewModel.placeList?[index].image ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          Padding(
                            padding: context.paddingNormal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomLargeText(
                                  text: viewModel.placeList?[index].name ?? "",
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLargeText(
                                      text:
                                          "${viewModel.placeList?[index].price.toString()}",
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Row(
                                      children: [
                                        Wrap(
                                          children: List.generate(
                                            5,
                                            (count) {
                                              return Icon(
                                                count <
                                                        viewModel
                                                            .placeList![index]
                                                            .stars!
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: CustomColor.starColor,
                                              );
                                            },
                                          ),
                                        ),
                                        CustomLargeText(
                                          text:
                                              "(${viewModel.placeList?[index].stars.toString()}.0)",
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
