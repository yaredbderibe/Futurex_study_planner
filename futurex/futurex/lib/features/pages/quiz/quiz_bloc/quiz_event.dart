part of 'quiz_bloc.dart';


@immutable
sealed class QuizEvent {}


class QuizAnswerClickedEvent extends QuizEvent{
  int value;
  Color contColor;
  Color txtColor;
  String content;
  QuizAnswerClickedEvent({
    required this.value,
    required this.contColor,
    required this.txtColor,
    required this.content
});
}
