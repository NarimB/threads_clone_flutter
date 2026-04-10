import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_threads_clone/data/datasources/local_post_data_source.dart';
import 'package:flutter_threads_clone/data/repositories/post_repository_impl.dart';
import 'package:flutter_threads_clone/presentation/bloc/profile/profile_cubit.dart';
import 'package:flutter_threads_clone/presentation/bloc/profile/profile_state.dart';
import 'package:flutter_threads_clone/presentation/widgets/profile_content.dart';
import 'package:flutter_threads_clone/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(PostRepositoryImpl(LocalPostDataSource()))
            ..loadProfile(userId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Профиль',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final isOwnProfile = userId == 'me';

            if (state.status == ProfileStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.status == ProfileStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'Ошибка загрузки профиля'),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        context.read<ProfileCubit>().loadProfile(userId);
                      },
                      child: Text('Повторить'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                ProfileHeader(user: state.user!, isOwnProfile: isOwnProfile),
                Divider(height: 1),
                Expanded(
                  child: ProfileContent(
                    posts: state.posts,
                    isOwnProfile: isOwnProfile,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
