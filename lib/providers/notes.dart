import 'dart:collection';

import 'package:fios/models/note.dart';
import 'package:fios/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth.dart';

class Notes with ChangeNotifier {
  List<Note> _notes = [];

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  Future<void> getNotes() async {
    try {
      http.Response response = await http.get('$kUrl/notes/today', headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Note> loadedNotes = [];
        for (var no in data) {
          final note = Note.fromJson(no);
          loadedNotes.add(note);

          _notes = loadedNotes;

          notifyListeners();
        }
      }
      if (response.statusCode >= 400) {
        throw response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addNote(String note) async {
    try {
      final body = json.encode({'note': note});
      http.Response response =
          await http.post('$kUrl/notes/new_note', body: body, headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });

      if (response.statusCode == 200) {
        final note = json.decode(response.body);
        _notes.add(Note.fromJson(note));
        notifyListeners();
      }

      if (response.statusCode >= 400) {
        throw response.body;
      }
    } catch (e) {
      print(e);
    }
  }

// delete a note
  Future<bool> deleteNote(String noteId) async {
    try {
      bool success;
      http.Response response =
          await http.delete('$kUrl/notes/delete/$noteId', headers: {
        "Content-type": "application/json",
        "x-auth-token": await Auth.getToken(),
      });

      if (response.statusCode == 200) {
        _notes.removeWhere((note) {
          success = true;
          return note.id == noteId;
        });

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
