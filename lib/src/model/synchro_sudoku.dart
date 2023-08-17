import 'sudoku_values.dart';

/// represents a sudoku with a matrix of 9x9 that contains the clues
/// and a board to solve it
class SynchroSudoku {
  SudokuValues clues;
  SudokuValues board;

  /// creates a sudoku with no clues
  SynchroSudoku.empty()
      : clues = SudokuValues(),
        board = SudokuValues();

  /// creates a sudoku from the given clues and copy them into the board
  SynchroSudoku({required this.clues}) : board = SudokuValues();

  /// creates a sudoku from the given values and copy them into the board
  SynchroSudoku.fromValues(List<List<int>> values)
      : clues = SudokuValues(),
        board = SudokuValues() {
    if (values.length != 9) {
      throw Exception("values must be a 9x9 matrix");
    }
    for (int i = 0; i < 9; i++) {
      clues.setRow(i, values[i]);
    }
    board = clues.copy();
  }

  /// sample of a solved sudoku
  static SynchroSudoku get sample {
    return SynchroSudoku.fromValues([
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
  }

  SynchroSudoku.fromString(String str)
      : clues = SudokuValues(),
        board = SudokuValues() {
    if (str.length != 81) {
      throw Exception("string must be 81 lenght");
    }
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        int n = int.parse(str[r * 9 + c]);
        clues.setCell(r, c, n);
      }
    }
    board = clues.copy();
  }

  @override
  String toString() {
    return "clues ($cluesCount):\n$clues";
  }

  /// returns [true] if s.clues contains the same values
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

  /// returns the count of the clues that are not 0
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

  /// returns true if the cell at coordinates [r][c] is empty in the clues
  bool isEditable({required int r, required int c}) {
    return clues.getCell(r, c) == 0;
  }
}
