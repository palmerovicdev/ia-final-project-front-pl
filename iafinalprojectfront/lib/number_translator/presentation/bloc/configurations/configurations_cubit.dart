import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/config_data/configuration_data.dart';
import '../../../../config/connection/connection_helper.dart';
import '../../../../config/service_locator/service_locator.dart';

part 'configurations_state.dart';

class ConfigurationsCubit extends Cubit<ConfigurationsState> {
  ConfigurationsCubit() : super(const ConfigurationsInitial()){
    currentLanguage = tr("current_language");
  }

  TextEditingController controller = TextEditingController();
  String currentLanguage = 'Espanol';

  void setBaseUrl(String hotspotAddress, void Function() function) async {
    serviceLocator<ConfigurationData>().baseUrl = 'http://$hotspotAddress:34545';
    serviceLocator.get<ConnectionHelper>().setBaseUrl('http://$hotspotAddress:34545');
    controller.text = hotspotAddress;
    emit(state.copyWith(hotspotAddress: hotspotAddress));
    function.call();
  }

  void changeLanguage(bool spanish) {
    currentLanguage = spanish ? 'es' : 'en';
    emit(state.copyWith(isSpanishLanguage: spanish));
  }
}