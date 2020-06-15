// this file collects all the levels as an array
import 'dart:ui';

import '../../game.dart';
import '../level.dart';
import 'level1.dart';
import 'level2.dart';
import 'level3.dart';
import 'level4.dart';
import 'level5.dart';
import 'level6.dart';
import 'level7.dart';
import 'level8.dart';
import 'level9.dart';

const platformColor = Color(0xff333333);

List<Level Function(MonumentPlatformer)> levels = [
  // make level 1 = index 1
  null,
  level1,
  level2,
  level3,
  level4,
  level5,
  level6,
  level7,
  level8,
  level9,
];
