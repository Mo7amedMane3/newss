import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newss/di.dart';
import 'package:newss/models/categories_model.dart';
import 'package:newss/screens/bloc/cubit.dart';
import 'package:newss/screens/views/categories_view.dart';
import 'package:newss/screens/views/drawer_view.dart';
import 'package:newss/screens/views/sources_view.dart';

import '../core/theming/cubit/cubit.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        drawer: DrawerView(onClick: onDrawerClicked),
        appBar: AppBar(
          backgroundColor: ThemingCubit.get(context).colors.primary,
          centerTitle: true,
          title: Text(
            selectedCategory == null ? "Home" : selectedCategory!.label,
          ),
        ),

        body: selectedCategory == null
            ? CategoriesView(onClick: onClick)
            : SourcesView(categoryId: selectedCategory!.id),
      ),
    );
  }

  CategoriesModel? selectedCategory;

  void onDrawerClicked() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }

  void onClick(CategoriesModel category) {
    selectedCategory = category;
    setState(() {});
  }
}