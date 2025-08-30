
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/datasource/remote/news/types.dart';
import 'package:news/data/models/newsMoedl.dart';

import '../../../data/datasource/remote/news/client.dart';

part 'newsStates.dart';


class NewCubit extends Cubit<NewsStates> {
  final Client client;
  late NewsTypes newType;
  NewCubit(this.client) : super(NewsInit());

  void startLoadNews(NewsTypes type,int page, int pageSize) async
  {
    newType = type;
    emit(NewsLoading());
    final List<NewsModel> news =  await client.news.getNews(types: type, page: page, pageSize: pageSize);
    emit(NewsLoadedSuccessfully(news));
  }

  void getMoreNews(int page, int pageSize) async
  {
    emit(LoadingMoreNews());
    final news = await client.news.getNews(types: newType, page: page, pageSize: pageSize);
    await Future.delayed(Duration(seconds: 1));
    if(news.isEmpty) {
      emit(NoMoreNews());
    }
    emit(NewsLoadedSuccessfully(news));
  }
}