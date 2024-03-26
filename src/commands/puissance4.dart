import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../managers/puissance4.dart';

class Puissance4CMD extends MineralCommand with Environment {
  Puissance4CMD()
      : super(
            label: Display("puissance4"),
            description: Display("Démarrer un jeu de puissance4"),
            options: [
              CommandOption.user(Display("adversaire"),
                  Display("La personne que vous souhaitez affronter"),
                  required: true)
            ]);

  Future<void> handle(CommandInteraction command) async {
    User user = command.getValue<User>("adversaire");
    GuildMember member = user.toGuildMember(command.guild!.id)!;
    var channel = command.channel!;

    if (identical(member, command.member)) {
      await command.reply(
          content: "❌ Vous ne pouvez pas jouer contre vous-même...",
          private: true);
      return;
    }

    if (member.isBot) {
      await command.reply(
          content: "❌ Vous ne pouvez pas jouer contre un bot...",
          private: true);
      return;
    }

    if (Puissance4Manager().isPlaying(member) ||
        Puissance4Manager().isPlaying(command.member!)) {
      await command.reply(
          content: "❌ Les deux joueurs ne sont pas disponnibles...",
          private: true);
      return;
    }

    if (channel is TextBasedChannel) {
      EmbedBuilder embed = EmbedBuilder(
        author: EmbedAuthor(name: "PeaBot - Jeux", iconUrl: environment.get('ICON_URL')),
        color: Color(environment.get('COLOR')),
        description: """
        1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣

        🟡 🟡 🟡 🟡 🟡 🟡 🟡
        🟡 🟡 🟡 🟡 🟡 🟡 🟡
        🟡 🟡 🟡 🟡 🟡 🟡 🟡
        🟡 🟡 🟡 🟡 🟡 🟡 🟡
        🟡 🟡 🟡 🟡 🟡 🟡 🟡
        """,
        footer: EmbedFooter(text: "PeaBot | Jeux", iconUrl: environment.get('ICON_URL')),
        timestamp: DateTime.now(),
        title: "Le puissance 4",
      );

      await channel.send(embeds: [embed]);
      Message message = await channel.lastMessage!;

      Puissance4Manager().create(Puissance4(channel, command.member!, member, message));

      await command.reply(content: "✅ La partie a démarré !", private: true);
    }
  }
}
