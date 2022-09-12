import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/compenents/large_text.dart';
import '../../../core/compenents/text.dart';
import '../../../init/theme/colors.dart';
import '../../../product/compenents/app_button.dart';
import '../../../product/compenents/responsive_button.dart';
import '../viewmodel/home_page_viewmodel.dart';

class DetailPageView extends StatefulWidget {
  const DetailPageView({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<DetailPageView> createState() => _DetailPageViewState();
}

class _DetailPageViewState extends State<DetailPageView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomePageViewModel>(context);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                child: Image.network(
                  viewModel.placeList?[widget.index].image ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 40,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
            Positioned.fill(
              top: 300,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomLargeText(
                                text: viewModel.placeList?[widget.index].name ??
                                    "",
                                color: Colors.black.withOpacity(0.8),
                              ),
                              FittedBox(
                                child: CustomLargeText(
                                  text: viewModel
                                          .placeList?[widget.index].price ??
                                      "",
                                  color: CustomColor.mainColor,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: CustomColor.mainColor),
                              SizedBox(width: 5),
                              CustomText(
                                  text:
                                      viewModel.placeList?[widget.index].city ??
                                          "",
                                  color: CustomColor.textColor1)
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                  5,
                                  (count) {
                                    return Icon(
                                      count <
                                              viewModel.placeList![widget.index]
                                                  .stars!
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: CustomColor.starColor,
                                    );
                                  },
                                ),
                              ),
                              CustomText(
                                  text:
                                      "(${viewModel.placeList?[widget.index].stars.toString()}.0)"),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomLargeText(
                            text: "İnsan Sayısı",
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          CustomText(text: "Kaç kişi katılmak istiyorsunuz ?"),
                          SizedBox(height: 15),
                          Wrap(
                              children: List.generate(5, (index) {
                            return InkWell(
                              onTap: () =>
                                  viewModel.selectedIndexPeople = index,
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: AppButtons(
                                  color: viewModel.selectedIndexPeople == index
                                      ? Colors.white
                                      : Colors.black,
                                  size: 50,
                                  backgroundColor:
                                      viewModel.selectedIndexPeople == index
                                          ? Colors.black
                                          : CustomColor.buttonBackground,
                                  borderColor: CustomColor.buttonBackground,
                                  text: (index + 1).toString(),
                                ),
                              ),
                            );
                          })),
                          SizedBox(height: 15),
                          CustomLargeText(text: "Açıklama"),
                          CustomText(
                              text: viewModel.placeList?[widget.index].body ??
                                  ""),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  viewModel.isFavoriteButton =
                                      !viewModel.isFavoriteButton;
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: viewModel.isFavoriteButton
                                          ? CustomColor.mainColor
                                          : CustomColor.buttonBackground),
                                  child: viewModel.isFavoriteButton
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        )
                                      : Icon(Icons.favorite_outline),
                                ),
                              ),
                              ResponsiveButton(width: 250),
                            ],
                          ),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
