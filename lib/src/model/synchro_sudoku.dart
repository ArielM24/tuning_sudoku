import 'sudoku_values.dart';

class SynchroSudoku {
  SudokuValues clues;
  SynchroSudoku.empty() : clues = SudokuValues();
  SynchroSudoku({required this.clues});
  SynchroSudoku.fromValues(List<List<int>> values) : clues = SudokuValues() {
    for (int i = 0; i < 9; i++) {
      clues.setRow(i, values[i]);
    }
  }

  @override
  String toString() {
    return "clues ($cluesCount):\n$clues";
  }

  bool hasSameClues(SynchroSudoku s) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (clues.getCell(i, j) != s.clues.getCell(i, j)) {
          return false;
        }
      }
    }
    return true;
  }

  int get cluesCount {
    int count = 0;
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (clues.getCell(i, j) != 0) {
          count++;
        }
      }
    }
    return count;
  }
}
