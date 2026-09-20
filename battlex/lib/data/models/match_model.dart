class MatchModel {
  final String id;
  final String title;
  final String game; // BGMI, Free Fire, etc
  final String time;
  final int prizePool;
  final int entryFee;
  final int totalSpots;
  final int filledSpots;
  final bool isJoined;

  MatchModel({
    required this.id,
    required this.title,
    required this.game,
    required this.time,
    required this.prizePool,
    required this.entryFee,
    required this.totalSpots,
    required this.filledSpots,
    this.isJoined = false,
  });

  MatchModel copyWith({
    int? filledSpots,
    bool? isJoined,
  }) {
    return MatchModel(
      id: id,
      title: title,
      game: game,
      time: time,
      prizePool: prizePool,
      entryFee: entryFee,
      totalSpots: totalSpots,
      filledSpots: filledSpots ?? this.filledSpots,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}
