import 'package:mineral/core/api.dart';

class Puissance4Manager {
  static final Puissance4Manager _instance = Puissance4Manager._internal();

  List<Puissance4> games = [];

  bool isPlaying(GuildMember member) {
    for (var game in this.games) {
      if (identical(game.red, member) || identical(game.yellow, member))
        return true;
    }
    return false;
  }

  void create(Puissance4 game) {
    this.games.add(game);
  }

  factory Puissance4Manager() {
    return _instance;
  }

  Puissance4Manager._internal();
}

class Puissance4 {
  Puissance4(this.channel, this.red, this.yellow, this.message) {}

  TextBasedChannel channel;
  GuildMember red;
  GuildMember yellow;
  Message message;
}
