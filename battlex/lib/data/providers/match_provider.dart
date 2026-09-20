import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/match_model.dart';
import 'wallet_provider.dart';

final matchProvider = StateNotifierProvider<MatchNotifier, List<MatchModel>>((ref) {
  return MatchNotifier(ref);
});

class MatchNotifier extends StateNotifier<List<MatchModel>> {
  final Ref ref;

  MatchNotifier(this.ref) : super([]) {
    _loadMatches();
  }

  void _loadMatches() {
    state = [
      MatchModel(
        id: 'M1',
        title: 'BGMI Erangel Squads',
        game: 'BGMI',
        time: 'Today, 09:00 PM',
        prizePool: 5000,
        entryFee: 50,
        totalSpots: 100,
        filledSpots: 84,
      ),
      MatchModel(
        id: 'M2',
        title: 'Free Fire Clash Squad',
        game: 'Free Fire',
        time: 'Today, 10:30 PM',
        prizePool: 2000,
        entryFee: 20,
        totalSpots: 48,
        filledSpots: 48,
      ),
      MatchModel(
        id: 'M3',
        title: 'BGMI TDM 1v1',
        game: 'BGMI',
        time: 'Tomorrow, 02:00 PM',
        prizePool: 1000,
        entryFee: 100,
        totalSpots: 32,
        filledSpots: 12,
      ),
      MatchModel(
        id: 'M4',
        title: 'Ludo King Challenge',
        game: 'Ludo',
        time: 'Today, 08:00 PM',
        prizePool: 500,
        entryFee: 10,
        totalSpots: 10,
        filledSpots: 6,
      ),
    ];
  }

  /// Returns true if join succeeded, false if insufficient balance or match full.
  Future<bool> joinMatch(String matchId) async {
    final matchIndex = state.indexWhere((m) => m.id == matchId);
    if (matchIndex == -1) return false;

    final match = state[matchIndex];
    if (match.isJoined) return true;
    if (match.filledSpots >= match.totalSpots) return false;

    final walletNotifier = ref.read(walletProvider.notifier);
    final success = await walletNotifier.deductCash(
      match.entryFee.toDouble(),
      'Entry Fee - ${match.title}',
    );

    if (success) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == matchIndex)
            match.copyWith(filledSpots: match.filledSpots + 1, isJoined: true)
          else
            state[i]
      ];
      return true;
    }

    return false;
  }
}
