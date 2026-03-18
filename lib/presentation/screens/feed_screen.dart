import 'package:flutter/material.dart';
import 'package:flutter_threads_clone/domain/entities/post.dart';
import 'package:flutter_threads_clone/presentation/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [
      Post(
        id: '1',
        content: 'Красивый день в Астане!',
        authorId: '1',
        createdAt: DateTime.now().toString(),
        likes: 3,
      ),
      Post(
        id: '2',
        content: 'Working on my Flutter project!',
        authorId: '2',
        createdAt: DateTime.now().toString(),
        likes: 6,
      ),
      Post(
        id: '3',
        content: 'Знакомьтесь, это мой новый пост в Threads!',
        authorId: '3',
        createdAt: DateTime.now().toString(),
        likes: 9,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Threads v2.0',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(post: post);
        },
        separatorBuilder: (_, _) => Divider(height: 1),
        itemCount: posts.length,
      ),
    );
  }
}
