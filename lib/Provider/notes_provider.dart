import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:notes_app/Colors/colors.dart';
import 'package:notes_app/Model/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotesProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  NotesProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString('notes');
    if (notesJson != null) {
      final notesData = json.decode(notesJson) as List;
      _notes = notesData.map((noteJson) => Note.fromJson(noteJson)).toList();
      notifyListeners();
    }
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = json.encode(_notes.map((note) => note.toJson()).toList());
    await prefs.setString('notes', notesJson);
  }

  void addNote(String title, String description) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      color: AppColors.noteColors[_notes.length % AppColors.noteColors.length],
    );
    _notes.add(newNote);
    saveNotes();
    notifyListeners();
  }

  void updateNote(String id, String title, String description) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index] = Note(
        id: id,
        title: title,
        description: description,
        color: _notes[index].color,
      );
      saveNotes();
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    saveNotes();
    notifyListeners();
  }
}