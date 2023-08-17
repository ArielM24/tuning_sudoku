import 'dart:math';
import 'dart:isolate';

import 'package:tunning_sudoku/tunning_sudoku.dart';

enum SudokuDifficulty { easy, normal, hard, insane }

/// This class contains methods to generate sudokus
class SudokuGenerator {
  /// generates a sudoku with the given number of clues with a unique solution
  /// the less number of clues the more time it takes to generate it
  /// the minimun number of clues allowed to generated in a reasonable time is 25
  /// you can reduce the limit to 17 with [unsafe] = true but doing this may
  /// never ends, so don't change [unsafe] unless you know what you are doing
  SynchroSudoku generateSync({int clues = 35, bool unsafe = false}) {
    if (unsafe) {
      if (clues < 17) {
        throw Exception("invalid number of clues, the minimun allowed is 17");
      }
    } else {
      if (clues < 25) {
        throw Exception("invalid number of clues, the minimun allowed is 25");
      }
    }

    SynchroSudoku s = SynchroSudoku.sample;
    SudokuValues values = s.clues.copy();
    int cluesCount = 81;
    int iterations = 0;
    int maxIterations = 250 + (unsafe ? 400 : 0);
    while (cluesCount > clues) {
      iterations++;
      if (iterations >= maxIterations) {
        return generateSync(clues: clues, unsafe: unsafe);
      }
      int r = Random().nextInt(9);
      int c = Random().nextInt(9);
      if (values.getCell(r, c) == 0) {
        continue;
      }
      SudokuValues aux = values.copy();
      aux.setCell(r, c, 0);
      if (SudokuSolver()
          .hasUniqueSolutionSync(s: SynchroSudoku(clues: aux.copy()))) {
        cluesCount--;
        values = aux.copy();
        continue;
      }
    }
    print("iterations $iterations");
    return SynchroSudoku(clues: values);
  }

  /// generates a sudoku with the given number of clues with a unique solution
  /// the less number of clues the more time it takes to generate it
  /// the minimun number of clues allowed to generated in a reasonable time is 25
  /// you can reduce the limit to 17 with [unsafe] = true but doing this may
  /// never ends, so don't change [unsafe] unless you know what you are doing
  Future<SynchroSudoku> generate({int clues = 35}) async {
    SynchroSudoku s = await Isolate.run(() => generateSync(clues: clues));
    return s;
  }

  /// generates a sudoku from the given difficulty
  /// the more difficult the more time it takes to generate it
  SynchroSudoku generateFromDifficultySync(
      {SudokuDifficulty difficulty = SudokuDifficulty.normal}) {
    int clues = 0;
    switch (difficulty) {
      case SudokuDifficulty.easy:
        clues = Random().nextInt(6) + 40;
      case SudokuDifficulty.normal:
        clues = Random().nextInt(4) + 35;
      case SudokuDifficulty.hard:
        clues = Random().nextInt(3) + 30;
      case SudokuDifficulty.insane:
        clues = Random().nextInt(2) + 25;
    }
    return generateSync(clues: clues);
  }

  /// generates a sudoku from the given difficulty
  /// the more difficult the more time it takes to generate it
  Future<SynchroSudoku> generateFromDifficulty(
      {SudokuDifficulty difficulty = SudokuDifficulty.normal}) async {
    return await Isolate.run(
        () => generateFromDifficultySync(difficulty: difficulty));
  }
}
