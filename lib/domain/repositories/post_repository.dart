import 'package:flutter_threads_clone/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getFeed();
}
