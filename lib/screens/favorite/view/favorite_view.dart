import 'package:denemefirebaseauth/screens/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: viewModel.favoriteList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(viewModel.favoriteList[index].name ?? ""),
            );
          }),
    );
  }
}
