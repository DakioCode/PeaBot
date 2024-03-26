import 'dart:math';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

class PileOuFaceCMD extends MineralCommand with Environment {
  PileOuFaceCMD()
      : super(
            label: Display("pileouface"),
            description: Display("Jouer à pile ou face"));

  Future<void> handle(CommandInteraction command) async {
    bool result = Random().nextBool();
    String? url = environment.getOrFail("PILE_URL");

    if (result) {
      url = environment.getOrFail("PILE_URL");
    } else {
      url = environment.getOrFail("FACE_URL");
    }

    EmbedBuilder embed = EmbedBuilder(
      author: EmbedAuthor(name: "PeaBot - Jeux", iconUrl: environment.getOrFail('ICON_URL')),
      color: Color(environment.getOrFail('COLOR')),
      description: "Voici le résultat du pile ou face de <@${command.user.id}> : ||${result ? "pile" : "face"}|| !",
      footer: EmbedFooter(text: "PeaBot | Jeux", iconUrl: environment.getOrFail('ICON_URL')),
      timestamp: DateTime.now(),
      title: "Pile ou Face ?",
      thumbnail: EmbedThumbnail(url: url!)
    );

    await command.reply(embeds: [embed]);
  }
}
