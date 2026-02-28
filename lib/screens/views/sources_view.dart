import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newss/screens/bloc/cubit.dart';
import 'package:newss/screens/bloc/states.dart';
import 'package:newss/screens/news_screen.dart';

import '../../core/internet_checker.dart';
import '../../di.dart';

class SourcesView extends StatelessWidget {
  String categoryId;

  SourcesView({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    print(
      "InternetConnectivity() ${InternetConnectivity().isConnected}",
    );
    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>()..getSources(categoryId),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetSourcesLoadingState) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          var bloc = BlocProvider.of<HomeCubit>(context);
          return Column(
            children: [
              DefaultTabController(
                length: bloc.sources.length,
                initialIndex: bloc.selectedIndex,
                child: TabBar(
                  isScrollable: true,
                  onTap: (index) {
                    bloc.changeSelectedSource(index);
                  },
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  tabs: bloc.sources
                      .map((e) => Tab(child: Text(e.name ?? "")))
                      .toList(),
                ),
              ),
              Expanded(child: NewsScreen()),
            ],
          );
        },
      ),
    );
  }
}