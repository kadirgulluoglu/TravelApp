import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: IndexedStack(
          children: viewModel.pages, index: viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: viewModel.onTapBottomBar,
        currentIndex: viewModel.currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(label: "Ana Sayfa", icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label: "Bar", icon: Icon(Icons.explore)),
          BottomNavigationBarItem(label: "Ara", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Profil", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
