import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_threads_clone/domain/entities/user.dart';
import 'package:flutter_threads_clone/domain/repositories/post_repository.dart';
import 'package:flutter_threads_clone/presentation/bloc/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final PostRepository _postRepository;

  ProfileCubit(this._postRepository) : super(const ProfileState());

  Future<void> loadProfile(String userId) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final posts = await _postRepository.getPostsByUser(userId);
      final user = _getMockUser(userId, posts.length);
      emit(
        state.copyWith(status: ProfileStatus.success, user: user, posts: posts),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Ошибка загрузки профиля',
        ),
      );
    }
  }

  User _getMockUser(String userId, int postCount) {
    final mockUsers = {
      'me': User(
        id: 'me',
        username: 'me',
        bio: 'Flutter developer',
        avatarUrl: '',
        postsCount: postCount,
      ),
      '1': User(
        id: '1',
        username: 'Aizhan',
        bio: 'Люблю кофе и программирование на Flutter',
        avatarUrl: '',
        postsCount: postCount,
      ),
      '2': User(
        id: '2',
        username: 'Dani',
        bio: 'Backend developer',
        avatarUrl: '',
        postsCount: postCount,
      ),
      '3': User(
        id: '3',
        username: 'Qana',
        bio: 'IT user',
        avatarUrl: '',
        postsCount: postCount,
      ),
    };

    return mockUsers[userId] ??
        User(
          id: userId,
          username: userId,
          avatarUrl: '',
          postsCount: postCount,
        );
  }
}
