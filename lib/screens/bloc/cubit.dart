import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:newss/core/internet_checker.dart';
import 'package:newss/models/news_response.dart';
import 'package:newss/models/sources_response.dart';
import 'package:newss/screens/bloc/states.dart';
import 'package:newss/screens/repository/local/home_local_repo.dart';
import 'package:newss/screens/repository/remote/home_repo.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
    HomeRemoteRepo repo;
  HomeLocalRepo localRepo;

  HomeCubit(this.repo, this.localRepo) : super(HomeInitState());

  List<Sources> sources = [];
  List<Articles> articles = [];
  int selectedIndex = 0;

  void changeSelectedSource(int index) {
    selectedIndex = index;
    emit(OnChangeSourceTab());
    getNews();
  }

  Future<void> getNews() async {
    emit(GetNewsDataLoadingState());

    try {
      NewsResponse newsResponse = InternetConnectivity().isConnected
          ? await repo.getNews(sources[selectedIndex].id ?? "")
          : await localRepo.getNews(sources[selectedIndex].id ?? "");

      if (newsResponse.status == "error") {
        emit(GetNewsDataErrorState(newsResponse.message ?? ""));
        return;
      }

      articles = newsResponse.articles ?? [];
      emit(GetNewsDataSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetNewsDataErrorState(e.toString()));
    }
  }

  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoadingState());
    try {
      SourcesResponse sourcesResponse = InternetConnectivity().isConnected
          ? await repo.getSources(categoryId)
          : await localRepo.getSources(categoryId);

      sources = sourcesResponse.sources ?? [];

      emit(GetSourcesSuccessState());
      getNews();
    } catch (e) {
      emit(GetSourcesErrorState());
    }
  }
}