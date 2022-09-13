import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemefirebaseauth/product/enum/view_state.dart';
import 'package:denemefirebaseauth/screens/homepage/view/details_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/compenents/large_text.dart';
import '../../../core/compenents/text.dart';
import '../../../init/theme/colors.dart';
import '../../../models/user_model.dart';
import '../../../product/compenents/circle_tab_indicator.dart';
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
                _buildProfilePictureAndMenuIcon(),
                _buildTextDiscover(),
                const SizedBox(height: 10),
                _buildTabBar(),
                _buildTabBarView(viewModel),
                const SizedBox(height: 30),
                _buildDiscoverAllText(),
                const SizedBox(height: 10),
                _buildDiscoverAllItem()
              ],
            ),
          )
        : _buildLoadingCircular();
  }

  Future getFirebase() async {
    await FirebaseFirestore.instance
        .collection("person")
        .doc(user!.uid)
        .get()
        .then((value) => {
              this.userModel = UserModel.fromMap(value.data()),
              setState(() {}),
            });
  }

  Map<String, String> image = {
    "balloning": "Balon Turu",
    "hiking": "Dağ Yürüyüşü",
    "snorkling": "Dalış",
    "kayaking": "Kayak",
  };

  Center _buildLoadingCircular() {
    return Center(
      child: CircularProgressIndicator(
        color: CustomColor.mainColor,
      ),
    );
  }

  Container _buildDiscoverAllItem() {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(left: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: image.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 40),
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
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
      padding: const EdgeInsets.only(left: 20),
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
        labelPadding: const EdgeInsets.only(left: 20, right: 20),
        labelColor: Colors.black,
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        indicator: CircleTabIndicator(radius: 4, color: CustomColor.mainColor),
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
        margin: const EdgeInsets.only(left: 20),
        child: CustomLargeText(text: "Merhaba\n${userModel?.name ?? ""}"));
  }

  Container _buildProfilePictureAndMenuIcon() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, size: 30, color: Colors.black54),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(10), // Image radius
                child: Image.network('https://picsum.photos/200',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
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
                  padding: const EdgeInsets.only(right: 15, top: 10),
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
                            child: Image.network(
                              viewModel.placeList?[index].image ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
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
