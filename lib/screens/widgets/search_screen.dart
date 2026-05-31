import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newss/models/news_response.dart';

import '../../core/api_manger.dart';
import '../../models/article_item.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Articles> articles = [];
  int maxResult = 0;
  int currentPage = 10;
  String? errorMassage;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (searchController.text.isNotEmpty&&articles.length<maxResult) {
          _search();
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            toolbarHeight: 80,
            leading: SizedBox.shrink(),
            leadingWidth: 0,
            title: TextFormField(
              controller: searchController,
              onFieldSubmitted: (value) {
                currentPage = 1;
                maxResult = 0;
                _search();
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          if (articles.isEmpty && errorMassage == null)
            SliverToBoxAdapter(
              child: Lottie.asset('assets/animation/empty_list.json'),
            ),
          if (errorMassage != null)
            SliverToBoxAdapter(
              child: Text(
                errorMassage!,
                style: TextTheme.of(context).titleLarge,
              ),
            ),
          if (articles.isNotEmpty)
            SliverList.separated(
              itemCount: articles.length < maxResult
                  ? articles.length + 1
                  : articles.length,
              itemBuilder: (context, index) {
                if(index==articles.length){
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }else {
                  return ArticleItem(article: articles[index]);
                }
              },
              separatorBuilder: (context, index) => SizedBox(height: 16),
            ),
        ],
      ),
    );
  }

  void _search() async {
    try {
      var response = await ApiManager.searchArticles(
        searchQuery: searchController.text,
        pageNumber: currentPage,
      );
      // articles = response.articles ?? [];
      articles.addAll(response.articles ?? []);
      maxResult = response.totalResults?.toInt() ?? 0;
      currentPage++;
    } catch (e) {
      errorMassage = e.toString();
    }
    setState(() {});
  }
}
