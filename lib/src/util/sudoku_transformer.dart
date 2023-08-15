import 'dart:isolate';
import 'dart:math';

import '../../tunning_sudoku.dart';

/// this class contains methods to make transformations to sudokus while
/// keeping it with the same amount of solutions
class SynchroTransformer {
  /// randomly removes clues of a sudoku to the less possible while keeping it with a
  /// unique solution, for the less clues possible increase [iterations], for the
  /// most clues posible increate [iterations] and set [keepMax] to true.
  /// example:
  /// this complete sudoku can be reduced to a unsolved sudoku with a unique solution
  SynchroSudoku reduceToUniqueSync(
      {required SudokuValues v, int iterations = 10, bool keepMax = false}) {
    SudokuValues unique = v.copy();
    int r = Random().nextInt(9);
    int c = Random().nextInt(9);
    bool isUnique = true;
    int currentIteration = 0;
    int backup = 0;
    SynchroSudoku minUnique = SynchroSudoku(clues: unique.copy());

    while (isUnique) {
      while (unique.getCell(r, c) == 0) {
        r = Random().nextInt(9);
        c = Random().nextInt(9);
      }
      backup = unique.getCell(r, c);
      unique.setCell(r, c, 0);
      final SynchroSudoku aux = SynchroSudoku(clues: unique.copy());
      final solutions = SynchroSolver().getAllSolutions(s: aux, stopAfter: 2);
      if (solutions.length != 1) {
        currentIteration++;
        unique.setCell(r, c, backup);
        if (keepMax && currentIteration > 1) {
          if (aux.cluesCount > minUnique.cluesCount) {
            minUnique = SynchroSudoku(clues: unique.copy());
          }
        } else if (aux.cluesCount < minUnique.cluesCount) {
          minUnique = SynchroSudoku(clues: unique.copy());
        }

        if (currentIteration >= iterations) {
          isUnique = false;
          break;
        }
        unique = v.copy();
      }
    }
    return minUnique;
  }

  /// applies transformations to the given values while keekping the same amount
  /// of solutions
  SynchroSudoku randomTransformation(
      {required SudokuValues values,
      bool swapRows = true,
      bool swapCols = true,
      bool transpose = true,
      bool swapRowsInBox = true,
      bool swapColsInBox = true,
      bool rotate = true}) {
    SudokuValues transformed = values.copy();
    if (swapRows) {
      List<int> rows = [0, 3, 6]..shuffle();
      transformed.swapRows(rows[0], rows[1]);
      transformed.swapRows(rows[0] + 1, rows[1] + 1);
      transformed.swapRows(rows[0] + 2, rows[1] + 2);
    }
    if (swapCols) {
      List<int> cols = [0, 3, 6]..shuffle();
      transformed.swapColumns(cols[0], cols[1]);
      transformed.swapColumns(cols[0] + 1, cols[1] + 1);
      transformed.swapColumns(cols[0] + 2, cols[1] + 2);
    }
    if (swapRowsInBox) {
      List<int> rows1 = [0, 1, 2]..shuffle();
      List<int> rows2 = [3, 4, 5]..shuffle();
      List<int> rows3 = [6, 7, 8]..shuffle();
      SudokuValues aux = transformed.copy();
      for (int i = 0; i < 3; i++) {
        transformed.setRow(i, aux.getRow(rows1[i]));
      }
      for (int i = 0; i < 3; i++) {
        transformed.setRow(i + 3, aux.getRow(rows2[i]));
      }
      for (int i = 0; i < 3; i++) {
        transformed.setRow(i + 6, aux.getRow(rows3[i]));
      }
    }
    if (swapColsInBox) {
      List<int> cols1 = [0, 1, 2]..shuffle();
      List<int> cols2 = [3, 4, 5]..shuffle();
      List<int> cols3 = [6, 7, 8]..shuffle();
      SudokuValues aux = transformed.copy();
      for (int i = 0; i < 3; i++) {
        transformed.setColumn(i, aux.getColumn(cols1[i]));
      }
      for (int i = 0; i < 3; i++) {
        transformed.setColumn(i + 3, aux.getColumn(cols2[i]));
      }
      for (int i = 0; i < 3; i++) {
        transformed.setColumn(i + 6, aux.getColumn(cols3[i]));
      }
    }
    if (transpose && Random().nextBool()) {
      transformed = transformed.transpose();
    }
    if (rotate) {
      transformed = transformed.rotate(
          left: Random().nextBool(), times: 1 + Random().nextInt(4));
    }
    final t = SynchroSudoku(clues: transformed);
    return t;
  }

  /// get different [n] transformations for the given values while keekping the same amount
  /// of solutions, if a transformation is repetead while generating them, it well generate
  /// another one, the number of possible rerolls is determinated by [maxReroll]
  List<SynchroSudoku> getRandomTransformations(
      {required SynchroSudoku s, int n = 5, int maxReroll = 10}) {
    List<SynchroSudoku> transformations = [];
    int repeated = 0;
    if (n == 1) {
      return transformations..add(randomTransformation(values: s.clues));
    }
    for (int i = 0; i < n; i++) {
      if (repeated >= maxReroll) {
        break;
      }
      final t = randomTransformation(values: s.clues);
      if (transformations.any((s) => s.hasSameClues(t))) {
        i--;
        repeated++;
        continue;
      }

      transformations.add(t);
    }
    return transformations;
  }

  /// randomly removes clues of a sudoku to the less possible while keeping it with a
  /// unique solution, for the less clues possible increase [iterations], for the
  /// most clues posible increate [iterations] and set [keepMax] to true.
  /// example:
  /// this complete sudoku can be reduced to a unsolved sudoku with a unique solution
  Future<SynchroSudoku> reduceToUnique(
      {required SudokuValues v,
      int iterations = 1,
      bool keepMax = false}) async {
    final sudoku = await Isolate.run(() => reduceToUniqueSync(
        v: v.copy(), iterations: iterations, keepMax: keepMax));
    return sudoku;
  }

  /// returns a random sudoku with a unique solution
  SynchroSudoku randomSample() {
    return reduceToUniqueSync(
        v: getRandomTransformations(s: SynchroSudoku.sample, n: 1).first.clues);
  }
}
