import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Presentation/Widgets/CustomAppBar.dart';
import 'package:news/Presentation/Widgets/NewsTile.dart';
import 'package:news/Presentation/cubits/news_cubit/newCubit.dart';
import 'package:news/data/datasource/remote/news/client.dart';
import 'package:news/data/datasource/remote/news/types.dart';
import 'package:news/data/models/newsMoedl.dart';
import 'Presentation/Widgets/categoryCard.dart';
import 'gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() async {
  runApp(
      BlocProvider(
        create: (_) => NewCubit(Client(apiKey: "27c89b279c184ddd924655fa3d991856"))..startLoadNews(NewsTypes.general, 1, 10),
        child: const MyApp(),
      )
  );
}

NewsTypes? convert(String title)
{
  if(title == "entertaiment" ) {
    return NewsTypes.entertainment;
  } else if(title == "health"){
    return NewsTypes.health;
  }
  else if(title == "science"){
    return NewsTypes.science;
  }
  else if(title == "technology") {
    return NewsTypes.technology;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerCategory = ScrollController();
  int page = 2;
  int idx = 0;
  bool new_topic = false;
  static List<NewsModel> news = [];
  final List<String> catgories =  ["entertaiment","health","science","technology"];
  int current = -1;
  double to = 30;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        page++;
        context.read<NewCubit>().getMoreNews(page - 1, 10);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onHorizontalDragEnd: (details){
            if(details.velocity.pixelsPerSecond.dx > 0 ){
              setState(() {
                if(current - 1 >= 0) {
                  news= [];
                  current--;
                  to -= 30;
                  _scrollControllerCategory.animateTo( current ==0
                      ? 0.0
                      : to, duration: Duration(milliseconds: 1), curve: Curves.easeIn);

                  context.read<NewCubit>().startLoadNews(convert(catgories[current])!, 1, 10);
                }
              });
            }
            else
              {
                setState(() {
                  if(current +1 < catgories.length)
                    {
                      news= [];
                      current++;
                      to +=30;
                      if(current !=0) {
                        _scrollControllerCategory.animateTo( current == catgories.length - 1
                          ? _scrollControllerCategory.position.maxScrollExtent
                          : to, duration: Duration(milliseconds: 1), curve: Curves.easeIn);
                      }
                      context.read<NewCubit>().startLoadNews(convert(catgories[current])!, 1, 10);
                    }
                });
              }
          },
          child: BlocListener<NewCubit, NewsStates>(
            listener: (context, state) {
              if (state is NoMoreNews) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title:Center(
                      child: Text(
                        'Oops! 😞',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    content: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "You've reached the end of the news feed. Stay tuned for more updates coming soon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                    ),                  actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue
                          ),
                          child: Align(alignment: Alignment.center,child: Text("Ok", style:  TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: CustomAppBar(
                    firstWordAppTitle: "News",
                    secondWordAppTitle: "Cloud",
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                // Categories section
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        controller: _scrollControllerCategory,
                        scrollDirection: Axis.horizontal,
                        itemCount: Assets.images.values.length,
                        itemBuilder: (context, idx) {
                          String catgory = Assets.images.values[idx]
                              .substring(14, Assets.images.values[idx].length - 5);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CategoryCard(
                              isActive: current == -1 ? false : (catgories[current] == catgory),
                              callback: (){
                                setState(() {
                                  new_topic = true;
                                  current =  catgories.indexOf(Assets.images.values[idx]
                                      .substring(14, Assets.images.values[idx].length - 5).toString());
                                });
                              },
                              type: convert(Assets.images.values[idx]
                                  .substring(14, Assets.images.values[idx].length - 5))!,
                              imagePath: Assets.images.values[idx],
                              categoryName: Assets.images.values[idx]
                                  .substring(14, Assets.images.values[idx].length - 5),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                BlocBuilder<NewCubit, NewsStates>(
                  builder: (context, state) {
                    if (state is NewsLoading) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: 10,
                              (context, idx) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 11.0),
                              child: Skeletonizer(
                                enabled: true,
                                effect: const ShimmerEffect(
                                  baseColor: Color(0xFFE0E0E0),
                                  highlightColor: Color(0xFFF5F5F5),
                                  duration: Duration(seconds: 3),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(left: 14),
                                      title: Text("The title of the news"),
                                      subtitle: Text("The subtitle"),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is NewsLoadedSuccessfully) {
                      if(new_topic == false) {
                        news = [...news, ...state.news];
                      }
                      else
                        {
                          new_topic = false;
                          news = state.news;
                        }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, idx) {
                            return NewsTile(
                              imageLink: news[idx].imageUrl,
                              newTitle: news[idx].title,
                              subTitle: news[idx].description,
                            );
                          },
                          childCount: news.length,
                        ),
                      );
                    } else if (state is LoadingMoreNews) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollController.hasClients) {
                          _scrollController.animateTo(
                            _scrollController.offset + 550,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      });
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, idx) {
                            if (idx < news.length) {
                              return NewsTile(
                                imageLink: news[idx].imageUrl,
                                newTitle: news[idx].title,
                                subTitle: news[idx].description,
                              );
                            } else {
                              return Skeletonizer(
                                enabled: true,
                                effect: const ShimmerEffect(
                                  baseColor: Color(0xFFE0E0E0),
                                  highlightColor: Color(0xFFF5F5F5),
                                  duration: Duration(seconds: 3),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(left: 14),
                                      title: Text("The title of the news"),
                                      subtitle: Text("The subtitle"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          childCount: news.length + 5,
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, idx) {
                            return NewsTile(
                              imageLink: news[idx].imageUrl,
                              newTitle: news[idx].title,
                              subTitle: news[idx].description,
                            );
                          },
                          childCount: news.length,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
