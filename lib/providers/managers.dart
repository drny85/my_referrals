import 'dart:collection';
import 'dart:convert';

import 'package:fios/models/manager.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

class Managers extends ChangeNotifier {
  List<Manager> _managers = [];

  UnmodifiableListView<Manager> get managers => UnmodifiableListView(_managers);

  Future<void> getManagers() async {
    try {
      http.Response response = await http.get('$kUrl/manager/all', headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        List<Manager> loadedManagers = [];
        for (var man in decoded) {
          final manager = Manager.fromJson(man);

          loadedManagers.add(manager);
        }
        _managers = loadedManagers;
      }

      if (response.statusCode >= 400) {
        throw response.body;
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addManager({Manager manager}) async {
    try {
      bool success;
      final body = json.encode({
        'name': manager.name,
        'last_name': manager.lastName,
        'email': manager.email,
        'phone': manager.phone,
      });
      http.Response response =
          await http.post('$kUrl/manager/add-manager', body: body, headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });

      if (response.statusCode == 200) {
        success = true;
        final manager = Manager.fromJson(json.decode(response.body));
        _managers.add(manager);

        notifyListeners();
      }
      if (response.statusCode >= 400) {
        throw response.body;
      }

      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteManager(String id) async {
    try {
      bool success;
      http.Response response =
          await http.delete('$kUrl/manager/delete/$id', headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });

      if (response.statusCode == 200) {
        success = true;
        _managers.removeWhere((manager) => manager.id == id);
        notifyListeners();
      }
      if (response.statusCode >= 400) {
        throw response.body;
      }

      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
