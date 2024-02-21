enum TicTacToeCell { empty, x, o }

extension TicTacToeCellExtension on TicTacToeCell {
  String get symbol {
    switch (this) {
      case TicTacToeCell.x:
        return 'X';
      case TicTacToeCell.o:
        return 'O';
      default:
        return '';
    }
  }
}