import 'package:test/test.dart';
import 'package:tunning_sudoku/tunning_sudoku.dart';

void main() {
  group('Sudoku tests', () {
    test('Sudoku reduction', () {
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
      var unique = SudokuTransformer().reduceToUniqueSync(v: complete.clues);
      var solutions = SudokuSolver().getAllSolutionsSync(s: unique);
      expect(solutions.length, 1);
    });
    test('Sudoku solving', () {
      var incomplete = SynchroSudoku.fromValues([
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
      var solutions = SudokuSolver().getAllSolutionsSync(s: incomplete);
      expect(solutions.length, 1);
    });
    test('Sudoku transformation', () {
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
      var transformed =
          SudokuTransformer().getRandomTransformationsSync(s: complete, n: 1);
      var solutions = SudokuSolver().getAllSolutionsSync(s: transformed.first);
      expect(solutions.length, 1);
    });
    test('Sudoku generation', () {
      var generated = SudokuGenerator().generateSync();
      var solutions = SudokuSolver().getAllSolutionsSync(s: generated);
      expect(generated.cluesCount, 35);
      expect(solutions.length, 1);
    });
  });
}
