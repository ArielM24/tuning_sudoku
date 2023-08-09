import 'package:tunning_sudoku/src/util/sudoku_solver.dart';
import 'package:tunning_sudoku/src/util/sudoku_transformer.dart';
import 'package:tunning_sudoku/tunning_sudoku.dart';

void main() {
  var complete = SynchroSudoku.fromValues([
    [8, 2, 4, 6, 9, 7, 1, 5, 3],
    [3, 7, 9, 1, 2, 5, 4, 8, 6],
    [1, 5, 6, 4, 3, 8, 2, 9, 7],
    [6, 4, 7, 5, 8, 3, 9, 1, 2],
    [2, 1, 3, 7, 4, 9, 8, 6, 5],
    [9, 8, 5, 2, 1, 6, 7, 3, 4],
    [4, 9, 1, 3, 6, 2, 5, 7, 8],
    [5, 6, 2, 8, 7, 1, 3, 4, 9],
    [7, 3, 8, 9, 5, 4, 6, 2, 1],
  ]);
  var s = SynchroSudoku.fromValues([
    [0, 0, 4, 0, 0, 0, 1, 0, 3],
    [3, 0, 0, 0, 2, 0, 0, 8, 6],
    [0, 0, 0, 4, 0, 8, 2, 0, 0],
    [6, 0, 7, 5, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 4, 0, 0, 6, 0],
    [9, 0, 5, 2, 0, 0, 0, 0, 0],
    [0, 0, 0, 3, 0, 2, 5, 0, 0],
    [5, 0, 0, 0, 7, 0, 0, 4, 9],
    [0, 0, 8, 0, 0, 0, 6, 0, 1],
  ]);

  var x = SynchroSudoku.fromValues([
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [6, 0, 0, 0, 0, 8, 7, 1, 0],
    [0, 0, 0, 7, 0, 0, 3, 9, 0],
    [0, 4, 0, 0, 0, 1, 0, 7, 0],
    [5, 0, 7, 6, 0, 0, 0, 0, 0],
    [2, 6, 0, 0, 8, 0, 4, 0, 0],
    [0, 9, 0, 0, 3, 0, 0, 0, 0],
    [3, 0, 2, 1, 0, 6, 0, 0, 0],
    [0, 1, 0, 4, 2, 0, 0, 5, 0],
  ]);
  //print(x);
  final transformer = SynchroTransformer();
  //var t = SynchroTransformer().getRandomTransformations(s: s, n: 1500);
  //print(x.cluesCount);
  final solver = SynchroSolver();
  // var ss = solver.getAllSolutions(s: t.first);
  //print(ss.length);
  final unique = SynchroTransformer().reduceToUniqueSync(v: complete.clues);
  print(unique);
  print(unique.cluesCount);
  print(solver
      .getAllSolutions(
          s: transformer.getRandomTransformations(s: unique, n: 1500).first)
      .length);
}
