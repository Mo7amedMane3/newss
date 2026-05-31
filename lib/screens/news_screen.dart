import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/news_response.dart';
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
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        return ListView.separated(
          itemCount: bloc.articles.length,
          separatorBuilder: (context, index) =>
          const SizedBox(height: 12),
          itemBuilder: (context, index) {
            var article = bloc.articles[index];

            return InkWell(
              onTap: () {
                _showArticleDetails(article, context);
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
                  children: [

                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage ?? "",
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,

                        placeholder: (context, url) =>
                        const Center(
                          child: CircularProgressIndicator(),
                        ),

                        errorWidget: (context, url, error) =>
                        const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// TITLE
                    Text(
                      article.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// DESCRIPTION
                    Text(
                      article.description ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// AUTHOR + DATE
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          flex: 2,
                          child: Text(
                            article.author ?? "",
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
                            article.publishedAt
                                ?.substring(0, 10) ??
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
        );
      },
    );
  }

  void _showArticleDetails(
      Articles article,
      BuildContext context,) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,

      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,

                  children: [

                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),

                      child: CachedNetworkImage(
                        imageUrl:
                        article.urlToImage ?? "",

                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,

                        placeholder: (context, url) =>
                        const Center(
                          child:
                          CircularProgressIndicator(),
                        ),

                        errorWidget:
                            (context, url, error) =>
                        const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// TITLE
                    Text(
                      article.title ?? "",

                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DESCRIPTION
                    Text(
                      article.description ?? "",

                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// BUTTON
                    FilledButton(
                      onPressed: () {
                        launchUrl(Uri.parse(article.url ?? ""),mode: LaunchMode.inAppWebView);
                      },

                      style: FilledButton.styleFrom(
                        padding:
                        const EdgeInsets.all(16),

                        backgroundColor: Colors.black,

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                      ),

                      child: const Text(
                        "View Full Article",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}