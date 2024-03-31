import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class  ThemeEntity extends Equatable {
  final String name;
  final String? description;
  final ThemeMode themeMode;

  const ThemeEntity({
    required this.name,
    this.description,
    required this.themeMode,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        themeMode,
      ];

  // to map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'themeMode': themeMode.index,
    };
  }

  // from map
  factory ThemeEntity.fromMap(Map<String, dynamic> map) {
    return ThemeEntity(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      themeMode: ThemeMode.values[map['themeMode'] ?? 0],
    );
  }
}
