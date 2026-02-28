import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newss/screens/bloc/cubit.dart';
import 'package:newss/screens/home_screen.dart';

import 'core/internet_checker.dart';
import 'core/observer.dart';
import 'core/theming/cubit/cubit.dart';
import 'core/theming/cubit/states.dart';
import 'di.dart';
import 'models/SourcesAdaptor.dart';
import 'models/articles_adaptor.dart';
import 'models/news_response_adaptor.dart';
import 'models/sources_recponse_adaptor.dart';
import 'models/sources_response.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(SourcesAdapter());
  Hive.registerAdapter(SourcesResponseAdapter());
  Hive.registerAdapter(ArticlesAdapter());
  Hive.registerAdapter(NewsResponseAdapter());

  configureDependencies();
  getIt<InternetConnectivity>().initialize();

  runApp(BlocProvider(
    create: (context) => getIt<ThemingCubit>(),
      child: BlocBuilder<ThemingCubit, ThemingStates>(
        builder: (context, state) {
          return MyApp();
        },
      ),
  )
         );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}
