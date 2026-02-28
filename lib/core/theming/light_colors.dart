import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newss/core/theming/base_colors.dart';

class LightColors implements BaseColors{
  @override
  Color get background => Colors.blue.shade50;

  @override
  Color get primary => Colors.white;

  @override
  Color get secondary => Colors.black;

  @override
  Color get surface => Colors.grey;

}