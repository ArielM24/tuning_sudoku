import 'dart:math';

import 'package:tunning_sudoku/tunning_sudoku.dart';

class SudokuDataset {
  // insane 25 - 27 clues
  static const List<List<List<int>>> expert = [
    [
      [5, 6, 0, 0, 0, 0, 0, 0, 1],
      [0, 0, 0, 0, 5, 0, 0, 6, 0],
      [0, 0, 7, 8, 3, 0, 4, 0, 0],
      [0, 0, 5, 3, 0, 1, 0, 0, 0],
      [7, 0, 0, 0, 0, 0, 2, 0, 6],
      [2, 0, 0, 0, 0, 7, 0, 5, 0],
      [0, 0, 0, 0, 0, 0, 5, 3, 0],
      [0, 5, 1, 4, 0, 0, 0, 0, 0],
      [4, 0, 0, 0, 0, 2, 0, 0, 0],
    ]
  ];
  // hard 28 - 29 clues
  static const List<List<List<int>>> hard = [];
  // normal 30 - 34 clues
  static const List<List<List<int>>> normal = [];
  // easy 35 - 39 clues
  static const List<List<List<int>>> easy = [];
  // quick 41 - 45 clues
  static const List<List<List<int>>> quick = [];

  static SynchroSudoku get fromExpert {
    return SynchroSudoku.fromValues(expert[Random().nextInt(expert.length)]);
  }

  static SynchroSudoku get fromHard {
    return SynchroSudoku.fromValues(hard[Random().nextInt(hard.length)]);
  }

  static SynchroSudoku get fromNormal {
    return SynchroSudoku.fromValues(normal[Random().nextInt(normal.length)]);
  }

  static SynchroSudoku get fromEasy {
    return SynchroSudoku.fromValues(easy[Random().nextInt(easy.length)]);
  }

  static SynchroSudoku get fromQuick {
    return SynchroSudoku.fromValues(quick[Random().nextInt(quick.length)]);
  }
}
