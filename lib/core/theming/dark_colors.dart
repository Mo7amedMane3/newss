import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newss/core/theming/base_colors.dart';

class DarkColors implements BaseColors{
  @override
  Color get background => Colors.blue.shade50;

  @override
  Color get primary => Colors.black;

  @override
  Color get secondary => Colors.white;

  @override
  Color get surface => Colors.grey;

}