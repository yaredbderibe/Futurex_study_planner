import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState()) {
    on<QuizAnswerClickedEvent>((event, emit) {
      // TODO: implement event handler
       emit(QuizState(
           value: event.value,
           contColor: event.contColor,
           txtColor: event.txtColor,
           content: event.content,
       ));
    });
  }
}
