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
}
