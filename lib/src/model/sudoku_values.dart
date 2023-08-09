import 'package:tunning_sudoku/tunning_sudoku.dart';

class SudokuValues {
  static const _s = "---------------------------\n";

  final List<List<int>> _values;
  SudokuValues()
      : _values = List.generate(9, (index) => List.generate(9, (index) => 0));

  SudokuValues copy() {
    SudokuValues c = SudokuValues();
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        c._values[i][j] = _values[i][j];
      }
    }
    return c;
  }

  void setRow(int index, List<int> row) {
    if (index < 0 || index > 8) {
      throw Exception("row out of index [0...8]");
    }
    if (row.length != 9) {
      throw Exception("row must be 9 length");
    }
    _values[index] = row;
  }

  void swapRows(int r1, int r2) {
    if (r1 < 0 || r1 > 8) {
      throw Exception("row out of index [0...8]");
    }
    if (r2 < 0 || r2 > 8) {
      throw Exception("row out of index [0...8]");
    }
    final aux = _values[r1];
    _values[r1] = _values[r2];
    _values[r2] = aux;
  }

  List<int> getRow(int index) {
    if (index < 0 || index > 8) {
      throw Exception("row out of index [0...8]");
    }
    return _values[index];
  }

  void setColumn(int index, List<int> column) {
    if (index < 0 || index > 8) {
      throw Exception("column out of index [0...8]");
    }
    if (column.length != 9) {
      throw Exception("column must be 9 length");
    }
    for (int i = 0; i < 9; i++) {
      _values[i][index] = column[i];
    }
  }

  List<int> getColumn(int index) {
    if (index < 0 || index > 8) {
      throw Exception("column out of index [0...8]");
    }
    List<int> column = [];
    for (int i = 0; i < 9; i++) {
      column.add(_values[i][index]);
    }
    return column;
  }

  void swapColumns(int c1, int c2) {
    if (c1 < 0 || c1 > 8) {
      throw Exception("column out of index [0...8]");
    }
    if (c2 < 0 || c2 > 8) {
      throw Exception("column out of index [0...8]");
    }
    final aux = getColumn(c1);
    setColumn(c1, getColumn(c2));
    setColumn(c2, aux);
  }

  @override
  String toString() {
    return "$_s${_values.join("\n")}\n$_s";
  }

  SudokuValues transpose() {
    SudokuValues t = SudokuValues();
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        t._values[i][j] = _values[j][i];
      }
    }
    return t;
  }

  SudokuValues _leftRotate(SudokuValues v) {
    SudokuValues r = SudokuValues();
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        r._values[i][j] = v._values[j][(8) - i];
      }
    }
    return r;
  }

  SudokuValues leftRotate({int times = 1}) {
    SudokuValues rotated = _leftRotate(this);
    for (int i = 1; i < times; i++) {
      rotated = _leftRotate(rotated);
    }
    return rotated;
  }

  SudokuValues _rightRotate(SudokuValues v) {
    SudokuValues r = SudokuValues();
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        r._values[j][(8) - i] = v._values[i][j];
      }
    }
    return r;
  }

  SudokuValues rightRotate({int times = 1}) {
    SudokuValues rotated = _rightRotate(this);
    for (int i = 1; i < times; i++) {
      rotated = _rightRotate(rotated);
    }
    return rotated;
  }

  SudokuValues rotate({int times = 1, bool left = false}) {
    if (left) {
      return leftRotate(times: times);
    }
    return rightRotate(times: times);
  }

  int getCell(int r, int c) {
    if (r < 0 || r > 8) {
      throw Exception("row out of index [0...8]");
    }
    if (c < 0 || c > 8) {
      throw Exception("column out of index [0...8]");
    }
    return _values[r][c];
  }

  void setCell(int r, int c, int n) {
    if (r < 0 || r > 8) {
      throw Exception("row out of index [0...8]");
    }
    if (c < 0 || c > 8) {
      throw Exception("column out of index [0...8]");
    }
    _values[r][c] = n;
  }

  List<int> getBox({required int r, required int c}) {
    if (r < 0 || r > 8) {
      throw Exception("row out of index [0...8]");
    }
    if (c < 0 || c > 8) {
      throw Exception("column out of index [0...8]");
    }
    List<int> box = [];
    int startRow = (r ~/ 3) * 3;
    int startCol = (c ~/ 3) * 3;
    int endCol = startCol + 3;
    int endRow = startRow + 3;
    for (int i = startRow; i < endRow; i++) {
      for (int j = startCol; j < endCol; j++) {
        box.add(_values[i][j]);
      }
    }
    return box;
  }

  bool isValidInRow({required int n, required int r, required int c}) {
    // n already exists in a different cell than r, c
    int index = getRow(r).indexOf(n);
    return index == c || index == -1;
  }

  bool isValidInColumn({required int n, required int r, required int c}) {
    // n already exists in a different cell than r, c
    int index = getColumn(c).indexOf(n);
    return index == r || index == -1;
  }

  bool isValidInBox({required int n, required int r, required int c}) {
    int localR = r % 3;
    int localC = c % 3;
    int localIndex = localR * 3 + localC;
    // n already exists in a different cell than r, c
    int index = getBox(r: r, c: c).indexOf(n);
    return index == localIndex || index == -1;
  }

  bool isValid({required int n, required int r, required int c}) {
    return isValidInRow(n: n, r: r, c: c) &&
        isValidInColumn(n: n, r: r, c: c) &&
        isValidInBox(n: n, r: r, c: c);
  }

  bool isSolved() {
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (!isValid(n: getCell(r, c), r: r, c: c)) {
          return false;
        }
      }
    }
    return true;
  }
}
