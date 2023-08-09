import 'package:tunning_sudoku/tunning_sudoku.dart';

import '../model/sudoku_values.dart';

class SynchroSolver {
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
    //print("solutions ${solved.length}");
    if (solved.isNotEmpty) {
      //print("returning ${solved.length} solutions");
      return solved;
    }
    return [];
  }

  List<SudokuValues> getAllSolutions(
      {required SynchroSudoku s, int stopAfter = 50}) {
    return _allSolutionsBacktraking(
        r: 0, c: 0, s: s.clues.copy(), stopAfter: stopAfter);
  }
}
