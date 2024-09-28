import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_first_app/services/models.dart';
import 'package:my_first_app/shared/shared.dart';
import 'package:my_first_app/topics/drawer.dart';


Future<String> _getImageUrl(String path) async {
    return await FirebaseStorage.instance.ref().child(path).getDownloadURL();
}


class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TopicScreen(topic: topic),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: FutureBuilder<String>(
                  future: _getImageUrl('covers/${topic.img}'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader(); // Loading indicator
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Image.asset('assets/covers/default.png'); // Fallback
                    }
                    return Image.network(
                      snapshot.data!,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              Flexible(child: TopicProgress(topic: topic)),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  const TopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: topic.img,
            child: FutureBuilder<String>(
              future: _getImageUrl('covers/${topic.img}'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return Image.asset('assets/covers/default.png'); // Fallback
                }
                return Image.network(
                  snapshot.data!,
                  width: MediaQuery.of(context).size.width,
                );
              },
            ),
          ),
          Text(
            topic.title,
            style: const TextStyle(
              height: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          QuizList(topic: topic),
        ],
      ),
    );
  }
}
