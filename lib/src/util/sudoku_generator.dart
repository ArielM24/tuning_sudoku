import 'dart:math';
import 'dart:isolate';

import 'package:tunning_sudoku/tunning_sudoku.dart';

enum SudokuDifficulty { quick, easy, normal, hard, expert }

/// This class contains methods to generate sudokus
class SudokuGenerator {
  /// this is a expensive function! use [getFromDifficulty]
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
    return SynchroSudoku(clues: values);
  }

  /// this is a expensive function! use [getFromDifficulty]
  /// generates a sudoku with the given number of clues with a unique solution
  /// the less number of clues the more time it takes to generate it
  /// the minimun number of clues allowed to generated in a reasonable time is 25
  /// you can reduce the limit to 17 with [unsafe] = true but doing this may
  /// never ends, so don't change [unsafe] unless you know what you are doing
  Future<SynchroSudoku> generate({int clues = 35}) async {
    SynchroSudoku s = await Isolate.run(() => generateSync(clues: clues));
    return s;
  }

  /// this is a expensive function! use [getFromDifficulty]
  /// generates a sudoku from the given difficulty
  /// the more difficult the more time it takes to generate it
  SynchroSudoku generateFromDifficultySync(
      {SudokuDifficulty difficulty = SudokuDifficulty.normal}) {
    int clues = 0;
    switch (difficulty) {
      // 40 - 45 clues
      case SudokuDifficulty.quick:
        clues = Random().nextInt(6) + 40;
      // 35 - 39 clues
      case SudokuDifficulty.easy:
        clues = Random().nextInt(5) + 35;
      // 30 - 34 clues
      case SudokuDifficulty.normal:
        clues = Random().nextInt(5) + 30;
      // 28 - 29 clues
      case SudokuDifficulty.hard:
        clues = Random().nextInt(2) + 28;
      // 25 - 27 clues
      case SudokuDifficulty.expert:
        clues = Random().nextInt(3) + 25;
    }
    return generateSync(clues: clues);
  }

  /// this is a expensive function! use [getFromDifficulty]
  /// generates a sudoku from the given difficulty
  /// the more difficult the more time it takes to generate it
  Future<SynchroSudoku> generateFromDifficulty(
      {SudokuDifficulty difficulty = SudokuDifficulty.normal}) async {
    return await Isolate.run(
        () => generateFromDifficultySync(difficulty: difficulty));
  }

  /// gets a random sudoku from the given difficulty
  SynchroSudoku getFromDifficulty(
      {SudokuDifficulty difficulty = SudokuDifficulty.normal}) {
    switch (difficulty) {
      // 40 - 45 clues
      case SudokuDifficulty.quick:
        return SudokuTransformer()
            .getRandomTransformationsSync(s: SudokuDataset.randomQuick, n: 1)
            .first;

      // 35 - 39 clues
      case SudokuDifficulty.easy:
        return SudokuTransformer()
            .getRandomTransformationsSync(s: SudokuDataset.randomEasy, n: 1)
            .first;
      // 30 - 34 clues
      case SudokuDifficulty.normal:
        return SudokuTransformer()
            .getRandomTransformationsSync(s: SudokuDataset.randomNormal, n: 1)
            .first;

      // 28 - 29 clues
      case SudokuDifficulty.hard:
        return SudokuTransformer()
            .getRandomTransformationsSync(s: SudokuDataset.randomHard, n: 1)
            .first;

      // 25 - 27 clues
      case SudokuDifficulty.expert:
        return SudokuTransformer()
            .getRandomTransformationsSync(s: SudokuDataset.randomExpert, n: 1)
            .first;
    }
  }
}
