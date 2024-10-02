import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final Color color;

  Note({required this.id, required this.title, required this.description, required this.color});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color.value,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      color: Color(json['color']),
    );
  }
}