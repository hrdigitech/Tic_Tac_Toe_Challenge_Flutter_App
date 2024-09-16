import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/views/widgets/TicTactoeCell.dart';
import 'SettingController.dart';

class TicTacToeGameController extends GetxController {
  RxList<TicTacToeCell> board = List.filled(9, TicTacToeCell.empty).obs;
  RxBool isXPlaying = true.obs;
  RxBool isGameOver = false.obs;
  RxInt restartCounter = 0.obs;

  bool get isBoardFull => !board.contains(TicTacToeCell.empty);

  final AudioPlayer _audioPlayer = AudioPlayer();
  final SettingsController settingsController;

  // Constructor takes SettingsController
  TicTacToeGameController(this.settingsController);

  Future<void> _playAudio(String path) async {
    print("Volume state: ${settingsController.isVolumeOn.value}"); // Log volume state
    if (settingsController.isVolumeOn.value) {
      print("Playing audio: $path"); // Log when audio is being played
      await _audioPlayer.play(AssetSource(path));
    } else {
      print("Audio is muted. Skipping: $path"); // Log when audio is skipped
    }
  }

  void robotPlayMove() {
    if (!isGameOver.value) {
      int bestMove = _getBestMove();
      print("Robot plays move at index: $bestMove"); // Log robot's move

      Future.delayed(const Duration(seconds: 1), () {
        playMove(bestMove);
      });
    }
  }

  int _getBestMove() {
    int bestScore = -1000;
    int move = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == TicTacToeCell.empty) {
        board[i] = TicTacToeCell.o;
        int score = _minimax(board, 0, false);
        board[i] = TicTacToeCell.empty;

        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    return move;
  }

  int _minimax(List<TicTacToeCell> board, int depth, bool isMaximizing) {
    if (_isWinner(TicTacToeCell.o)) return 1;
    if (_isWinner(TicTacToeCell.x)) return -1;
    if (isBoardFull) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == TicTacToeCell.empty) {
          board[i] = TicTacToeCell.o;
          int score = _minimax(board, depth + 1, false);
          board[i] = TicTacToeCell.empty;
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == TicTacToeCell.empty) {
          board[i] = TicTacToeCell.x;
          int score = _minimax(board, depth + 1, true);
          board[i] = TicTacToeCell.empty;
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

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

  void playMove(int index) async {
    if (!isGameOver.value && board[index] == TicTacToeCell.empty) {
      board[index] = isXPlaying.value ? TicTacToeCell.x : TicTacToeCell.o;
      isXPlaying.value = !isXPlaying.value;

      print("Playing move at index: $index"); // Log player's move
      await _playAudio('audios/onTapAudio.mp3');

      if (_checkGameOver()) {
        isGameOver.value = true;
        if (_isWinner(TicTacToeCell.x)) {
          print("X wins!"); // Log when X wins
          await _playAudio('audios/YouWon.m4a');
        } else if (_isWinner(TicTacToeCell.o)) {
          print("O wins!"); // Log when O wins
          await _playAudio('audios/YouLose.m4a');
        } else {
          print("It's a draw!"); // Log when it's a draw
        }
      }
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
      return condition.every((index) => board[index] == player);
    });
  }

  bool _checkGameOver() {
    return _isWinner(TicTacToeCell.x) ||
        _isWinner(TicTacToeCell.o) ||
        isBoardFull;
  }

  void restartGame() {
    board.value = List.filled(9, TicTacToeCell.empty);
    isXPlaying.value = true;
    isGameOver.value = false;
    restartCounter.value++;
    print("Game restarted. Total restarts: ${restartCounter.value}"); // Log game restarts
  }
}
