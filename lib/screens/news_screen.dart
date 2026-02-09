import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/api_manger.dart';
import '../models/news_response.dart';

class NewsScreen extends StatelessWidget {
  final String sourceId;
  const NewsScreen({super.key, required this.sourceId});



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.getNewsData(sourceId),
         builder: (context,snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return Center(child: CircularProgressIndicator(),);
           } else if (snapshot.hasError) {
             return Center(child: Text("Error"),);
           }
           List<Articles>articles = snapshot.data?.articles ?? [];

           if(articles.isEmpty){
             return Center(child: Text("No News Found"),);
           }
           return ListView.separated(
             separatorBuilder: (context, index) =>
                 SizedBox(height: 12),
             itemBuilder: (context, index) {
               return Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12),
                   border: Border.all(color: Colors.grey),

                 ),
                 padding: EdgeInsets.all(12),
                 margin: EdgeInsets.all(8),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   spacing: 4,
                   children: [
                     ClipRRect(
                         borderRadius: BorderRadius.circular(18),
                         child: Image.network(articles[index].urlToImage ?? "",
                           height: 220,
                           width: double.infinity,
                           fit: BoxFit.cover,
                         )),
                     Text(articles[index].title ?? "",maxLines: 1,
                     style: GoogleFonts.poppins(
                       fontSize: 18,
                       fontWeight: FontWeight.bold,
                     )),
                     Text(articles[index].description ?? "",maxLines: 2,
                         style: GoogleFonts.poppins(
                           fontSize: 14,
                           fontWeight: FontWeight.w400,
                           color: Colors.grey,
                         )),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(articles[index].author ?? "",maxLines: 2,
                             style: GoogleFonts.poppins(
                               fontSize: 14,
                               fontWeight: FontWeight.w400,
                               color: Colors.black,
                             )),
                         Text(articles[index].publishedAt?.substring(0,10) ?? "",maxLines: 2,
                             style: GoogleFonts.poppins(
                               fontSize: 14,
                               fontWeight: FontWeight.w400,
                               color: Colors.black,
                             )),
                       ],
                     ),
                     SizedBox(height: 4),
                   ],
                 ),
               );
             },
             itemCount: articles.length,
           );
         }

         );
  }
}
