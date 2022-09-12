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
      body: Stack(
        children: [
          _buildImage(viewModel),
          _buildCloseIcon(context),
          _buildPlaceDetails(context, viewModel),
        ],
      ),
    );
  }

  Positioned _buildPlaceDetails(
      BuildContext context, HomePageViewModel viewModel) {
    return Positioned.fill(
      top: 300,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        width: MediaQuery.of(context).size.width,
        height: 500,
        decoration: _boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildPlaceNameAndPrice(viewModel),
                  const SizedBox(height: 10),
                  _buildPlaceCity(viewModel),
                  const SizedBox(height: 10),
                  _buildStars(viewModel),
                  const SizedBox(height: 10),
                  CustomLargeText(
                      text: "İnsan Sayısı",
                      color: Colors.black.withOpacity(0.8),
                      size: 20),
                  CustomText(text: "Kaç kişi katılmak istiyorsunuz ?"),
                  const SizedBox(height: 15),
                  _buildPeopleNumberButton(viewModel),
                  const SizedBox(height: 15),
                  CustomLargeText(text: "Açıklama"),
                  _buildPlaceSubtitle(viewModel),
                  const SizedBox(height: 25),
                  _buildFavIconAndCustomButton(viewModel),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildFavIconAndCustomButton(HomePageViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            viewModel.isFavoriteButton = !viewModel.isFavoriteButton;
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
                ? const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )
                : const Icon(Icons.favorite_outline),
          ),
        ),
        ResponsiveButton(width: 250),
      ],
    );
  }

  CustomText _buildPlaceSubtitle(HomePageViewModel viewModel) {
    return CustomText(text: viewModel.placeList?[widget.index].body ?? "");
  }

  Wrap _buildPeopleNumberButton(HomePageViewModel viewModel) {
    return Wrap(
        children: List.generate(5, (index) {
      return InkWell(
        onTap: () => viewModel.selectedIndexPeople = index,
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          child: AppButtons(
            color: viewModel.selectedIndexPeople == index
                ? Colors.white
                : Colors.black,
            size: 50,
            backgroundColor: viewModel.selectedIndexPeople == index
                ? Colors.black
                : CustomColor.buttonBackground,
            borderColor: CustomColor.buttonBackground,
            text: (index + 1).toString(),
          ),
        ),
      );
    }));
  }

  Row _buildStars(HomePageViewModel viewModel) {
    return Row(
      children: [
        Wrap(
          children: List.generate(
            5,
            (count) {
              return Icon(
                count < viewModel.placeList![widget.index].stars!
                    ? Icons.star
                    : Icons.star_border,
                color: CustomColor.starColor,
              );
            },
          ),
        ),
        CustomText(
            text: "(${viewModel.placeList?[widget.index].stars.toString()}.0)"),
      ],
    );
  }

  Row _buildPlaceCity(HomePageViewModel viewModel) {
    return Row(
      children: [
        Icon(Icons.location_on, color: CustomColor.mainColor),
        const SizedBox(width: 5),
        CustomText(
            text: viewModel.placeList?[widget.index].city ?? "",
            color: CustomColor.textColor1)
      ],
    );
  }

  Row _buildPlaceNameAndPrice(HomePageViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomLargeText(
          text: viewModel.placeList?[widget.index].name ?? "",
          color: Colors.black.withOpacity(0.8),
        ),
        FittedBox(
          child: CustomLargeText(
            text: viewModel.placeList?[widget.index].price ?? "",
            color: CustomColor.mainColor,
            size: 22,
          ),
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }

  Positioned _buildCloseIcon(BuildContext context) {
    return Positioned(
      left: 20,
      top: 40,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Positioned _buildImage(HomePageViewModel viewModel) {
    return Positioned(
      left: 0,
      right: 0,
      child: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: Image.network(
          viewModel.placeList?[widget.index].image ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
