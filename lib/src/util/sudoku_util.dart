import 'dart:math';

import '../../tunning_sudoku.dart';
import '../model/sudoku_values.dart';

SynchroSudoku randomTransformation(
    {required SudokuValues values,
    bool swapRows = true,
    bool swapCols = true,
    bool transpose = true,
    bool swapRowsInBox = true,
    bool swapColsInBox = true,
    bool rotate = true}) {
  if (swapRows) {
    List<int> rows = [0, 3, 6]..shuffle();
    values.swapRows(rows[0], rows[1]);
    values.swapRows(rows[0] + 1, rows[1] + 1);
    values.swapRows(rows[0] + 2, rows[1] + 2);
  }
  if (swapCols) {
    List<int> cols = [0, 3, 6]..shuffle();
    values.swapColumns(cols[0], cols[1]);
    values.swapColumns(cols[0] + 1, cols[1] + 1);
    values.swapColumns(cols[0] + 2, cols[1] + 2);
  }
  if (swapRowsInBox) {
    List<int> rows1 = [0, 1, 2]..shuffle();
    List<int> rows2 = [3, 4, 5]..shuffle();
    List<int> rows3 = [6, 7, 8]..shuffle();
    SudokuValues aux = values.copy();
    for (int i = 0; i < 3; i++) {
      values.setRow(i, aux.getRow(rows1[i]));
    }
    for (int i = 0; i < 3; i++) {
      values.setRow(i + 3, aux.getRow(rows2[i]));
    }
    for (int i = 0; i < 3; i++) {
      values.setRow(i + 6, aux.getRow(rows3[i]));
    }
  }
  if (swapColsInBox) {
    List<int> cols1 = [0, 1, 2]..shuffle();
    List<int> cols2 = [3, 4, 5]..shuffle();
    List<int> cols3 = [6, 7, 8]..shuffle();
    SudokuValues aux = values.copy();
    for (int i = 0; i < 3; i++) {
      values.setColumn(i, aux.getColumn(cols1[i]));
    }
    for (int i = 0; i < 3; i++) {
      values.setColumn(i + 3, aux.getColumn(cols2[i]));
    }
    for (int i = 0; i < 3; i++) {
      values.setColumn(i + 6, aux.getColumn(cols3[i]));
    }
  }
  if (transpose && Random().nextBool()) {
    values = values.transpose();
  }
  if (rotate) {
    values = values.rotate(
        left: Random().nextBool(), times: 1 + Random().nextInt(4));
  }
  final t = SynchroSudoku(clues: values);
  return t;
}
