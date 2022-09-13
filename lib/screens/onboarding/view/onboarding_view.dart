import 'package:denemefirebaseauth/screens/home/view/home_view.dart';
import 'package:denemefirebaseauth/screens/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/compenents/large_text.dart';
import '../../../core/compenents/text.dart';
import '../../../init/theme/colors.dart';
import '../../../product/compenents/responsive_button.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List images = ["welcome-one.png", "welcome-two.png", "welcome-three.png"];
  List text = ["Doğal Ortamlar", "Tarihi Yapılar", "Yol Rehberi"];
  List subtitle = [
    "Sıra dışı benzersiz dağların güzelliklerini keşfetmek için hazır olun...",
    "Tarihi yapıları görmek için sabırsızlanıyorsan doğru yerdesin hemen bize katıl",
    "Senin için en iyi rehber bu mobil uygulamada saklı"
  ];

  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/${images[index]}"),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLargeText(
                          text: "Seyahat",
                        ),
                        CustomText(
                          text: text[index],
                          size: 30,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 250,
                          child: CustomText(
                            text: subtitle[index],
                            color: CustomColor.textColor2,
                            size: 14,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ResponsiveButton(
                            onPressed: () {
                              if (index == images.length - 1) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                      create: (context) => HomeViewModel(),
                                      child: const HomeView(),
                                    ),
                                  ),
                                );
                              } else {
                                _controller.nextPage(
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.linearToEaseOut);
                              }
                            },
                            width: 120),
                      ],
                    ),
                    Column(
                      children: List.generate(images.length, (indexDots) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width: 8,
                          height: index == indexDots ? 25 : 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index == indexDots
                                  ? CustomColor.mainColor
                                  : CustomColor.mainColor.withOpacity(0.3)),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
