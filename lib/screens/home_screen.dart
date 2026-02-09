import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newss/core/api_manger.dart';
import 'package:newss/models/sources_response.dart';
import 'package:newss/screens/news_screen.dart';


class HomeScreen extends StatefulWidget {
  static const String  routeName='/';
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("News",),
      ),
      body: FutureBuilder(
          future: ApiManger.getSources(),
          builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return Center(child: Text("Error"),);

        }
        List<Sources>sources=snapshot.data?.sources ??[];
     return Column(
       children: [
         DefaultTabController(
             length: sources.length,
             initialIndex: selectedIndex,
             child:TabBar(
               isScrollable: true,
               onTap: (index){
                 selectedIndex=index;
                 setState(() {

                 });
               },
               indicatorColor: Colors.transparent,

               dividerColor: Colors.transparent,
                 tabAlignment: TabAlignment.start,

                 tabs: sources.map((e) => Tab(child:Text(e.name ?? ""),)).toList()
             )
         ),
         Expanded(child: NewsScreen(sourceId: sources[selectedIndex].id ?? ""))
       ],
     );}
          ),
    );
  }
}
