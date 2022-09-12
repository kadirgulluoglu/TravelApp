import 'package:denemefirebaseauth/screens/homepage/viewmodel/home_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../homepage/view/home_page_view.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List _pages = [
    ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: const HomePageView(),
    ),
    Center(
        child: Text(
      "Keşfet",
      style: TextStyle(fontSize: 45),
    )),
    Container(color: Colors.redAccent),
    Container(color: Colors.blueGrey),
  ];
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: _pages[viewModel.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: viewModel.onTapBottomBar,
        currentIndex: viewModel.currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(label: "Ana Sayfa", icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label: "Bar", icon: Icon(Icons.explore)),
          BottomNavigationBarItem(label: "Ara", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Profil", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
