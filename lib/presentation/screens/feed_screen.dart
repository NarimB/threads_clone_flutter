import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_threads_clone/presentation/bloc/feed_cubit.dart';
import 'package:flutter_threads_clone/presentation/bloc/feed_state.dart';
import 'package:flutter_threads_clone/presentation/screens/create_post_screen.dart';
import 'package:flutter_threads_clone/presentation/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Threads v2.0',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePostScreen()),
              );
            },
            icon: Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: BlocConsumer<FeedCubit, FeedState>(
        builder: (context, state) {
          if (state.posts.isEmpty && state.status == FeedStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.posts.isEmpty && state.status != FeedStatus.loading) {
            return const Center(child: Text('Нет постов'));
          }

          return Column(
            children: [
              if (state.status == FeedStatus.loading && state.posts.isNotEmpty)
                const LinearProgressIndicator(),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostCard(post: post);
                  },
                  separatorBuilder: (_, _) => Divider(height: 1),
                  itemCount: state.posts.length,
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FeedStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Ошибка')),
            );
          }
        },
      ),
    );
  }
}
