import 'dart:isolate';

import 'package:tunning_sudoku/tunning_sudoku.dart';

/// This class contains methods to solve sudokus
class SudokuSolver {
  List<SudokuValues> _allSolutionsBacktraking(
      {required int r,
      required int c,
      required SudokuValues s,
      int stopAfter = 50}) {
    // out of boundaries (solved)
    if (r == 8 && c == 9) {
      return [s];
    }
    // solve next row
    if (c == 9) {
      c = 0;
      r++;
    }
    // cell already has a value
    if (s.getCell(r, c) > 0) {
      return _allSolutionsBacktraking(
          r: r, c: c + 1, s: s.copy(), stopAfter: stopAfter);
    }
    List<SudokuValues> solved = [];
    for (int n = 1; n <= 9; n++) {
      // find valid value for current cell and try to solve with this value
      if (s.isValid(n: n, r: r, c: c)) {
        s.setCell(r, c, n);
        final result = _allSolutionsBacktraking(
            r: r, c: c + 1, s: s.copy(), stopAfter: stopAfter);
        if (result.isNotEmpty) {
          solved.addAll(result);
        }
        if (solved.length >= stopAfter) {
          return solved;
        }
      }
      // no solution with this value
      s.setCell(r, c, 0);
    }
    if (solved.isNotEmpty) {
      return solved;
    }
    return [];
  }

  /// return a list with all the posible solutions fot the given sudoku
  /// using backtraking, the search for solutions can be limited with [stopAfter]
  /// note a well formed sudoku will only have a unique solution
  List<SudokuValues> getAllSolutionsSync(
      {required SynchroSudoku s, int stopAfter = 50}) {
    return _allSolutionsBacktraking(
        r: 0, c: 0, s: s.clues.copy(), stopAfter: stopAfter);
  }

  /// returns true if the given sudoku has only 1 solution
  bool hasUniqueSolutionSync({required SynchroSudoku s}) {
    return _allSolutionsBacktraking(r: 0, c: 0, s: s.clues.copy(), stopAfter: 2)
            .length ==
        1;
  }

  /// returns true if the given sudoku has at least 1 solution
  bool hasSolutionSync({required SynchroSudoku s}) {
    return _allSolutionsBacktraking(r: 0, c: 0, s: s.clues.copy(), stopAfter: 2)
        .isNotEmpty;
  }

  /// return a list with all the posible solutions fot the given sudoku
  /// using backtraking, the search for solutions can be limited with [stopAfter]
  /// note a well formed sudoku will only have a unique solution
  Future<List<SudokuValues>> getAllSolutions(
      {required SynchroSudoku s, int stopAfter = 50}) async {
    return await Isolate.run(() => _allSolutionsBacktraking(
        r: 0, c: 0, s: s.clues.copy(), stopAfter: stopAfter));
  }

  /// returns true if the given sudoku has only 1 solution
  Future<bool> hasUniqueSolution({required SynchroSudoku s}) async {
    return (await Isolate.run(() => _allSolutionsBacktraking(
                r: 0, c: 0, s: s.clues.copy(), stopAfter: 2)))
            .length ==
        1;
  }

  /// returns true if the given sudoku has at least 1 solution
  Future<bool> hasSolution({required SynchroSudoku s}) async {
    return (await Isolate.run(() => _allSolutionsBacktraking(
            r: 0, c: 0, s: s.clues.copy(), stopAfter: 2)))
        .isNotEmpty;
  }
}
