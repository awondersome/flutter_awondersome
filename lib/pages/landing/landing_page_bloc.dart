import 'package:flutter_awondersome/model/landing_config_model.dart';
import 'package:flutter_awondersome/bloc/config_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

sealed class LandingPageEvent {}

final class HaveLoadedNetworkImageEvent extends LandingPageEvent {}

final class CountEvent extends LandingPageEvent {}

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc() : super(LandingPageState()) {
    on<HaveLoadedNetworkImageEvent>((event, emit) {
      state.isCounterVisible = true;
      emit(LandingPageState.copyWith(state));
    });
    on<CountEvent>((event, emit) {
      --state.landingConfigModel.counter;
      emit(LandingPageState.copyWith(state));
    });
  }
}

class LandingPageState {
  LandingConfigModel landingConfigModel = LandingConfigModel();
  bool isCounterVisible = false;

  LandingPageState() {
    landingConfigModel = GetIt.I<ConfigBloc>().state.landingConfigModel;
  }

  LandingPageState.copyWith(LandingPageState newState) {
    landingConfigModel = newState.landingConfigModel;
    isCounterVisible = newState.isCounterVisible;
  }
}
