import 'package:flutter_threads_clone/domain/entities/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comments_state.freezed.dart';

enum CommentsStatus { initial, loading, success, failure }

@freezed
abstract class CommentsState with _$CommentsState {
  const factory CommentsState({
    @Default(CommentsStatus.initial) CommentsStatus status,
    @Default([]) List<Comment> comments,
    @Default('') String inputText,
    String? errorMessage,
  }) = _CommentsState;

  const CommentsState._();

  bool get canSubmit =>
      inputText.trim().isNotEmpty && status != CommentsStatus.loading;
}
