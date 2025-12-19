import 'package:flutter/material.dart';

/// Represents the degree of connection in a professional network
enum ConnectionDegree {
  first('1°', '1st degree connection', Color(0xFF4CAF50)),
  second('2°', '2nd degree connection', Color(0xFF2196F3)),
  third('3°', '3rd degree connection', Color(0xFF9E9E9E));

  const ConnectionDegree(this.label, this.description, this.color);

  final String label;
  final String description;
  final Color color;

  /// Parse from integer (1, 2, 3)
  static ConnectionDegree fromInt(int degree) {
    switch (degree) {
      case 1:
        return ConnectionDegree.first;
      case 2:
        return ConnectionDegree.second;
      case 3:
        return ConnectionDegree.third;
      default:
        return ConnectionDegree.third;
    }
  }

  int get value {
    switch (this) {
      case ConnectionDegree.first:
        return 1;
      case ConnectionDegree.second:
        return 2;
      case ConnectionDegree.third:
        return 3;
    }
  }
}
