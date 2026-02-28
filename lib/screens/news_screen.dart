import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'bloc/cubit.dart';
import 'bloc/states.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetNewsDataLoadingState) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<HomeCubit>(context);

        if (state is GetNewsDataErrorState) {
          return Center(child: Text("Something went wrong"));
        }

        return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: (){
                showModalBottomSheet(context: context, builder: (context) {
                  return Container(

                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(18),
                          child: CachedNetworkImage(
                            imageUrl: bloc.articles[index].urlToImage ?? "",
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Text(
                          bloc.articles[index].title ?? "",
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bloc.articles[index].description ?? "",
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,

                            color: Colors.grey,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                bloc.articles[index].author ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,

                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                bloc.articles[index].publishedAt?.substring(0, 10) ??
                                    "",
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,

                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey),
                ),
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(18),
                      child: CachedNetworkImage(
                        imageUrl: bloc.articles[index].urlToImage ?? "",
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                      ),
                    ),
                    Text(
                      bloc.articles[index].title ?? "",
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bloc.articles[index].description ?? "",
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,

                        color: Colors.grey,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            bloc.articles[index].author ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,

                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            bloc.articles[index].publishedAt?.substring(0, 10) ??
                                "",
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,

                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: bloc.articles.length,
        );
      },
    );
  }
}
