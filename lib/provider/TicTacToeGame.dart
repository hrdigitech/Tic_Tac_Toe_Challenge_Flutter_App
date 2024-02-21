import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/views/widgets/TicTactoeCell.dart';

class TicTacToeGame extends ChangeNotifier {
  List<TicTacToeCell> _board = List.filled(9, TicTacToeCell.empty);
  List<TicTacToeCell> get board => _board;

  bool _isXPlaying = true;
  bool get isXPlaying => _isXPlaying;

  bool get isBoardFull => !_board.contains(TicTacToeCell.empty);

  bool _isGameOver = false;
  bool get isGameOver => _isGameOver;

  String get resultMessage {
    if (_isWinner(TicTacToeCell.x)) {
      return 'X wins!';
    } else if (_isWinner(TicTacToeCell.o)) {
      return 'O wins!';
    } else if (isBoardFull) {
      return 'Draw!';
    } else {
      return '';
    }
  }

  void playMove(int index) {
    if (!_isGameOver && _board[index] == TicTacToeCell.empty) {
      _board[index] = _isXPlaying ? TicTacToeCell.x : TicTacToeCell.o;
      _isXPlaying = !_isXPlaying;
      if (_checkGameOver()) {
        _isGameOver = true;
      }
      notifyListeners();
    }
  }

  bool _isWinner(TicTacToeCell player) {
    List<List<int>> winningConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    return winningConditions.any((condition) {
      return condition.every((index) => _board[index] == player);
    });
  }

  bool _checkGameOver() {
    return _isWinner(TicTacToeCell.x) ||
        _isWinner(TicTacToeCell.o) ||
        isBoardFull;
  }

  void robotPlayMove() {
    if (!_isGameOver) {
      final emptyCells =
      _board.asMap().entries.where((entry) => entry.value == TicTacToeCell.empty).map((entry) => entry.key).toList();
      final randomIndex = Random().nextInt(emptyCells.length);
      playMove(emptyCells[randomIndex]);
    }
  }

  void restartGame() {
    _board = List.filled(9, TicTacToeCell.empty);
    _isXPlaying = true;
    _isGameOver = false;
    notifyListeners();
  }
}