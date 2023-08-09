import 'package:tunning_sudoku/src/util/sudoku_util.dart';
import 'package:tunning_sudoku/tunning_sudoku.dart';

void main() {
  var s = SynchroSudoku.empty();
  s.clues.setColumn(2, [1, 2, 3, 4, 5, 6, 7, 8, 9]);
  s.clues.setRow(2, [1, 2, 3, 4, 5, 6, 7, 8, 9]);
  print(s);
  var t = randomTransformation(values: s.clues);
  print(t);
}
