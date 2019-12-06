import 'dart:collection';
import 'dart:convert';

import 'package:fios/models/referee.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

class Referees extends ChangeNotifier {
  List<Referee> _referees = [];

  UnmodifiableListView<Referee> get referees => UnmodifiableListView(_referees);

  List<Referee> get sortedReferees {
    return _referees
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  Future<void> getReferees() async {
    try {
      http.Response response = await http.get('$kUrl/referee/all', headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        List<Referee> loadedReferees = [];
        for (var ref in decoded) {
          final referee = Referee.fromJson(ref);
          loadedReferees.add(referee);
        }
        _referees = loadedReferees;
      }

      if (response.statusCode >= 400) {
        throw response.body;
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addReferee({Referee referee}) async {
    try {
      bool success;
      final body = json.encode({
        'name': referee.name,
        'last_name': referee.lastName,
        'email': referee.email,
        'phone': referee.phone,
      });
      http.Response response =
          await http.post('$kUrl/referee/add-referee', body: body, headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });

      if (response.statusCode == 200) {
        success = true;
        final referee = Referee.fromJson(json.decode(response.body));
        _referees.add(referee);

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

  Future<bool> deleteRefefee(String id) async {
    try {
      bool success;
      http.Response response =
          await http.delete('$kUrl/referee/delete/$id', headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });

      if (response.statusCode == 200) {
        success = true;
        _referees.removeWhere((ref) => ref.id == id);
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
