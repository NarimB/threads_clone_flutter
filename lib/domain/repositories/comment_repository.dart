import 'package:flutter_threads_clone/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments(String postId);
  Future<void> addComment(Comment comment);
  Future<int> getCommentCount(String postId);
}
