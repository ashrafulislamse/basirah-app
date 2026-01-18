/// Prayer entity - Core business object
class Prayer {
  final String name;
  final DateTime time;
  final bool prayed;

  const Prayer({
    required this.name,
    required this.time,
    this.prayed = false,
  });

  /// Check if prayer time is upcoming
  bool isUpcoming() => time.isAfter(DateTime.now());

  /// Check if prayer time has passed
  bool isPassed() => time.isBefore(DateTime.now());

  /// Get time remaining until prayer
  Duration timeRemaining() => time.difference(DateTime.now());

  /// Get time since prayer passed
  Duration timeSince() => DateTime.now().difference(time);

  /// Copy with method for immutability
  Prayer copyWith({
    String? name,
    DateTime? time,
    bool? prayed,
  }) {
    return Prayer(
      name: name ?? this.name,
      time: time ?? this.time,
      prayed: prayed ?? this.prayed,
    );
  }

  @override
  String toString() => 'Prayer(name: $name, time: $time, prayed: $prayed)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Prayer &&
        other.name == name &&
        other.time == time &&
        other.prayed == prayed;
  }

  @override
  int get hashCode => Object.hash(name, time, prayed);
}
