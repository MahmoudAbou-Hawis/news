import 'package:flutter/material.dart';
import 'package:news/Presentation/Widgets/CustomAppBar.dart';
import 'package:news/Presentation/Widgets/NewsTile.dart';
import 'package:news/data/datasource/remote/news/client.dart';
import 'package:news/data/datasource/remote/news/types.dart';
import 'Presentation/Widgets/categoryCard.dart';
import 'gen/assets.gen.dart';

void main() async {
  runApp(const MyApp());
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: CustomAppBar(
                firstWordAppTitle: "News",
                secondWordAppTitle: "Cloud",
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Assets.images.values.length,
                    itemBuilder: (context, idx) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CategoryCard(
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

            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, idx) {
                  return NewsTile(
                    imageLink:
                    "https://upload.wikimedia.org/wikipedia/commons/3/3f/Fronalpstock_big.jpg",
                    newTitle: "ahmed $idx",
                    subTitle: "subtitle $idx",
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
