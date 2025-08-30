part of 'newCubit.dart';

sealed class NewsStates extends Equatable {

  const NewsStates();

  @override
  List<Object?> get props => [];
}

class NewsInit extends NewsStates {}

class NewsLoading extends NewsStates {}

class NewsLoadedSuccessfully extends NewsStates {
  final List<NewsModel> news;

  const NewsLoadedSuccessfully(this.news);
}

class LoadingMoreNews extends NewsStates {}

class NoMoreNews extends NewsStates {
}