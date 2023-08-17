class SudokuDataset {
  // insane 25 - 27 clues
  static const List<List<List<int>>> expert = [
    [
      [5, 6, 0, 0, 0, 0, 0, 0, 1],
      [0, 0, 0, 0, 5, 0, 0, 6, 0],
      [0, 0, 7, 8, 3, 0, 4, 0, 0],
      [0, 0, 5, 3, 0, 1, 0, 0, 0],
      [7, 0, 0, 0, 0, 0, 2, 0, 6],
      [2, 0, 0, 0, 0, 7, 0, 5, 0],
      [0, 0, 0, 0, 0, 0, 5, 3, 0],
      [0, 5, 1, 4, 0, 0, 0, 0, 0],
      [4, 0, 0, 0, 0, 2, 0, 0, 0],
    ]
  ];
  // hard 28 - 29 clues
  static const List<List<List<int>>> hard = [];
  // normal 30 - 34 clues
  static const List<List<List<int>>> normal = [];
  // easy 35 - 39 clues
  static const List<List<List<int>>> easy = [];
  // quick 41 - 45 clues
  static const List<List<List<int>>> quick = [];
}
