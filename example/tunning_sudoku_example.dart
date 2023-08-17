import 'package:tunning_sudoku/tunning_sudoku.dart';

void main() async {
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

  final solver = SudokuSolver();
  // delete cells from solved sudoku to the minimum posible while keeping a unique solution
  final unique = await SudokuTransformer().reduceToUnique(v: complete.clues);
  print("unsolved:");
  print(unique);
  // get all the solutions for the incomplete sudoku (a well formed sudoku only has 1 solution)
  final solution =
      solver.getAllSolutionsSync(s: incomplete, stopAfter: 1).first;
  print("solved:");
  print(solution);
  final transformer = SudokuTransformer();
  // get different sudokus with unique solutions from the given one
  final transformed =
      transformer.getRandomTransformationsSync(s: incomplete, n: 1).first;
  print("random transformation:");
  print(transformed);

  // generate a sudoku with the given number of clues
  var generated = SudokuGenerator().generateSync(clues: 27);
  print(generated);
  print(SudokuSolver().hasUniqueSolutionSync(s: generated));

  // generate a sudoku from a default difficulty
  var difficulty = SudokuGenerator()
      .generateFromDifficultySync(difficulty: SudokuDifficulty.expert);
  print(difficulty);

  // load a sudoku from a string
  var fromString = SynchroSudoku.fromString(
      "070000043040009610800634900094052000358460020000800530080070091902100005007040802");
  print(fromString);

  // load a sudoku from internal dataset
  var fromDataset = SudokuDataset.randomExpert;
  print(fromDataset);

  // generate a sudoku from a default difficulty
  var predifined =
      SudokuGenerator().getFromDifficulty(difficulty: SudokuDifficulty.expert);
  print(predifined);
}
