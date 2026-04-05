import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_threads_clone/presentation/bloc/comments/comments_cubit.dart';
import 'package:flutter_threads_clone/presentation/bloc/comments/comments_state.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({super.key, required this.authorName});

  final String authorName;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late TextEditingController _commentController;

  @override
  void initState() {
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 30),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: Text(
              widget.authorName[0].toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade100,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: _commentController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Напишите комментарий...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                context.read<CommentsCubit>().inputChanged(value);
              },
            ),
          ),
          const SizedBox(width: 8),
          BlocConsumer<CommentsCubit, CommentsState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == CommentsStatus.success) {
                _commentController.clear();
              }

              if (state.status == CommentsStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage ?? 'Ошибка при публикации комментария',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return TextButton(
                onPressed: state.canSubmit
                    ? () {
                        context.read<CommentsCubit>().addComment();
                      }
                    : null,
                child: Icon(
                  Icons.send,
                  size: 20,
                  color: state.canSubmit
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
