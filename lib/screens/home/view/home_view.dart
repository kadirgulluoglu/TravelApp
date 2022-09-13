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
        items: [
          _buildBottomItem("Ana Sayfa", Icons.home),
          _buildBottomItem("Favori", Icons.favorite),
          _buildBottomItem("Ara", Icons.search),
          _buildBottomItem("Profil", Icons.person),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomItem(String title, IconData icon) =>
      BottomNavigationBarItem(
          label: title,
          icon: Icon(
            icon,
          ));
}
