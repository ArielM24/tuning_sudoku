import 'dart:math';

import 'package:tunning_sudoku/src/dataset/expert.dart';
import 'package:tunning_sudoku/src/dataset/solved.dart';
import 'package:tunning_sudoku/tunning_sudoku.dart';

import 'easy.dart';
import 'hard.dart';
import 'normal.dart';
import 'quick.dart';

class SudokuDataset {
  // insane 25 - 27 clues
  static final List<SynchroSudoku> expert = [];
  // hard 28 - 29 clues
  static final List<SynchroSudoku> hard = [];
  // normal 30 - 34 clues
  static final List<SynchroSudoku> normal = [];
  // easy 35 - 39 clues
  static final List<SynchroSudoku> easy = [];
  // quick 41 - 45 clues
  static final List<SynchroSudoku> quick = [];
  // full solved
  static final List<SynchroSudoku> solved = [];

  static bool _expertLoaded = false;
  static bool _hardLoaded = false;
  static bool _normalLoaded = false;
  static bool _easyLoaded = false;
  static bool _quickLoaded = false;
  static bool _solvedLoaded = false;

  static SynchroSudoku get randomExpert {
    _loadExpertDataset();
    return (expert[Random().nextInt(expert.length)]);
  }

  static SynchroSudoku get randomHard {
    _loadHardDataset();
    return (hard[Random().nextInt(hard.length)]);
  }

  static SynchroSudoku get randomNormal {
    _loadNormalDataset();
    return (normal[Random().nextInt(normal.length)]);
  }

  static SynchroSudoku get randomEasy {
    _loadEasyDataset();
    return (easy[Random().nextInt(easy.length)]);
  }

  static SynchroSudoku get randomQuick {
    _loadQuickDataset();
    return (quick[Random().nextInt(quick.length)]);
  }

  static SynchroSudoku get randomSolved {
    _loadSolvedDataset();
    return (solved[Random().nextInt(solved.length)]);
  }

  static _loadExpertDataset() {
    if (_expertLoaded) {
      return;
    }
    for (var line in expertStr) {
      expert.add(SynchroSudoku.fromString(line));
    }
    _expertLoaded = true;
  }

  static _loadHardDataset() {
    if (_hardLoaded) {
      return;
    }
    for (var line in hardStr) {
      hard.add(SynchroSudoku.fromString(line));
    }
    _hardLoaded = true;
  }

  static _loadNormalDataset() {
    if (_normalLoaded) {
      return;
    }
    for (var line in normalStr) {
      normal.add(SynchroSudoku.fromString(line));
    }
    _normalLoaded = true;
  }

  static _loadEasyDataset() {
    if (_easyLoaded) {
      return;
    }
    for (var line in easyStr) {
      easy.add(SynchroSudoku.fromString(line));
    }
    _easyLoaded = true;
  }

  static _loadQuickDataset() {
    if (_quickLoaded) {
      return;
    }
    for (var line in quickStr) {
      quick.add(SynchroSudoku.fromString(line));
    }
    _quickLoaded = true;
  }

  static _loadSolvedDataset() {
    if (_solvedLoaded) {
      return;
    }
    for (var line in solvedStr) {
      solved.add(SynchroSudoku.fromString(line));
    }
    _solvedLoaded = true;
  }

  static SynchroSudoku randomFromClues(int clues) {
    switch (clues) {
      // 40 - 45 clues
      case > 39 && <= 45:
        return randomQuick;
      // 35 - 39 clues
      case > 34 && <= 39:
        return randomEasy;
      // 30 - 34 clues
      case > 29 && <= 34:
        return randomNormal;
      // 28 - 29 clues
      case > 27 && <= 29:
        return randomHard;
      // 25 - 27 clues
      case > 24 && <= 27:
        return randomExpert;
      default:
        return randomNormal;
    }
  }
}
