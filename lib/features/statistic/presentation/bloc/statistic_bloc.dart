import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticInitial());

  @override
  Stream<StatisticState> mapEventToState(
    StatisticEvent event,
  ) async* {

  }
}
