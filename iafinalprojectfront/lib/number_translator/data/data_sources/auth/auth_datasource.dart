import 'package:flutter/cupertino.dart';

import '../../../../config/config_data/configuration_data.dart';
import '../../../../config/connection/connection_helper.dart';
import '../../../../config/service_locator/service_locator.dart';
import '../../models/user_model.dart';

abstract class AuthDatasource {
  Future<bool> signUp(UserModel userModel);

  Future<bool> logIn(UserModel userModel);
}

class AuthDatasourceImpl extends AuthDatasource {

  final ConnectionHelper connectionHelper;

  AuthDatasourceImpl({required this.connectionHelper});

  @override
  Future<bool> logIn(UserModel userModel) async{
    var response = <String, dynamic>{};
    try {
      if (serviceLocator.get<ConfigurationData>().debugging) {
        response = {
          "version": "0",
          "response": {
            "status": "200",
            "message": "",
            "data": [
              {
                "username": "pepe",
                "password": "123123"
              }
            ]
          }
        };
        debugPrint('DEBUGGING');
        return response['response']['status'] == '200';
      }
      debugPrint('NOT DEBUGGING');
      response = (await connectionHelper.dio.post(
        '/user/login',
        data: userModel.toJson(),
      ))
          .data;
      debugPrint(response['response'].toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }

    return response['response']['status'] == '200';
  }

  @override
  Future<bool> signUp(UserModel userModel) async{
    var response = <String, dynamic>{};
    try {
      if (serviceLocator.get<ConfigurationData>().debugging) {
        response = {
          "version": "0",
          "response": {
            "status": "200",
            "message": "",
            "data": [
              {
                "username": "pepe",
                "password": "123123"
              }
            ]
          }
        };
        debugPrint('DEBUGGING');
        return response['response']['status'] == '200';
      }
      debugPrint('NOT DEBUGGING');
      response = (await connectionHelper.dio.post(
        '/user/signUp',
        data: userModel.toJson(),
      ))
          .data;
      debugPrint(response['response'].toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }

    return response['response']['status'] == '200';
  }
}