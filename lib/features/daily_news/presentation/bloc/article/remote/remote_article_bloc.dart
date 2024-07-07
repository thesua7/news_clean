import 'package:bloc/bloc.dart';
import 'package:news_clean/core/resources/data_state.dart';
import 'package:news_clean/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_clean/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_clean/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticleLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticleError(dataState.error!));
    }
  }
}
