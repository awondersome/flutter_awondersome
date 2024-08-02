import 'package:flutter_awondersome/model/landing_config_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ConfigEvent {}

final class SetLandingConfigEvent extends ConfigEvent {
  LandingConfigModel landingConfigModel;
  SetLandingConfigEvent({required this.landingConfigModel});
}

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigState()) {
    on<SetLandingConfigEvent>((event, emit) {
      state.landingConfigModel = event.landingConfigModel;
      emit(ConfigState.copyWith(state));
    });
  }
}

class ConfigState {
  LandingConfigModel landingConfigModel = LandingConfigModel();

  ConfigState();

  ConfigState.copyWith(ConfigState newState) {
    landingConfigModel = newState.landingConfigModel;
  }
}
