import 'dart:math';

import 'package:mineral/core/api.dart';
import 'package:mineral/framework.dart';

class DeCMD extends MineralCommand {
  DeCMD()
    : super(label: Display("dé"), description: Display("Lancer un dé de 6 chiffres."));

  Future<void> handle(CommandInteraction command) async {
    int number = Random().nextInt(6);

    while (true) {
      if (number > 0)
        break;
      else
        number = Random().nextInt(6);
    }

    await command.reply(content: "Le résultat du dé que j'ai lancé pour ${command.member} est : **${number}** ! 🎲");
  }
}