import 'sudoku_values.dart';

class SynchroSudoku {
  SudokuValues clues;
  SynchroSudoku.empty() : clues = SudokuValues();
  SynchroSudoku({required this.clues});

  @override
  String toString() {
    return "clues:\n$clues";
  }
}
