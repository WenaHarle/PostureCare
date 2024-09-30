// lib/gradient_utils.dart
import 'package:flutter/material.dart';

LinearGradient buildGradient() {
  return LinearGradient(
    colors: [Color(0xFFFFA726), Color(0xFFFFD95B)], // Orange to yellow gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
