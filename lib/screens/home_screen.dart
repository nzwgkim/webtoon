import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_services.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "Today's Webtoon",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 방법 1
            // return ListView(
            //   children: [
            //     for (var webtoon in snapshot.data!) Text(webtoon.title)
            //   ],
            // );

            // 방법 2
            // return ListView.builder(
            //   itemBuilder: (context, index) {
            //     print(index);
            //     var current = snapshot.data![index];
            //     return Text(current.title);
            //   },
            //   scrollDirection: Axis.horizontal,
            //   itemCount: snapshot.data!.length,
            // );

            // 방법3 : ListView.builder에서, builder를 separated로 바꿨다.
            // return ListView.separated(
            //   itemBuilder: (context, index) {
            //     print(index);
            //     var current = snapshot.data![index];
            //     return Text(current.title);
            //     // return Image.network(current.thumb);
            //   },
            //   // separatorBuilder: 어떻게 구분을 보여줄 것인지를 정한다. 매우 쉽다.
            //   separatorBuilder: (context, index) => const SizedBox(
            //     width: 20,
            //   ),
            //   scrollDirection: Axis.horizontal,
            //   itemCount: snapshot.data!.length,
            // );

            // 방법4
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        // stateless widget으로 분리함. webtoon_widget.dart
        // title, thumb, id 정보가 필요하므로, constructor를 수정함.
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
