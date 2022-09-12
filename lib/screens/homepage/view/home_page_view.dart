import 'package:denemefirebaseauth/screens/homepage/view/details_page_view.dart';
import 'package:denemefirebaseauth/screens/homepage/viewmodel/home_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/compenents/large_text.dart';
import '../../../core/compenents/text.dart';
import '../../../init/theme/colors.dart';
import '../../../product/compenents/circle_tab_indicator.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Map<String, String> image = {
    "balloning": "Balon Turu",
    "hiking": "Dağ Yürüyüşü",
    "snorkling": "Dalış",
    "kayaking": "Kayak",
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomePageViewModel>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 70, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.menu, size: 30, color: Colors.black54),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(10), // Image radius
                      child: Image.network('https://picsum.photos/200',
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20),
              child: CustomLargeText(text: "Dünyayı Keşfet")),
          SizedBox(height: 10),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: EdgeInsets.only(left: 20, right: 20),
                labelColor: Colors.black,
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                indicator:
                    CircleTabIndicator(radius: 4, color: CustomColor.mainColor),
                tabs: [
                  Tab(text: "Yerler"),
                  Tab(text: "Seyahat"),
                  Tab(text: "Diğerleri"),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            height: 270,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.placeList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<HomePageViewModel>.value(
                            value: viewModel,
                            child: DetailPageView(),
                          ),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 15, top: 10),
                        width: 205,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(30), // Image radius
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomLargeText(
                                        text:
                                            viewModel.placeList?[index].name ??
                                                "",
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Column(
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
                                                                  .placeList![
                                                                      index]
                                                                  .stars!
                                                          ? Icons.star
                                                          : Icons.star_border,
                                                      color:
                                                          CustomColor.starColor,
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
                    );
                  },
                ),
                Text("hi asdsadsad"),
                Text("hi sadasd"),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLargeText(text: "Daha fazlasını Keşfet", size: 22),
                CustomText(text: "Tümü", color: CustomColor.textColor1)
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 20),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(30), // Image radius
                              child: Image.asset(
                                  'assets/images/${image.keys.elementAt(index)}.png',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Container(
                          child: CustomText(
                            text: image.values.elementAt(index),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
