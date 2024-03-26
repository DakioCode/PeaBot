import 'dart:convert';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:http/http.dart' as http;

class ProfileCMD extends MineralCommand {
  ProfileCMD(): super(
    label: Display('profil'),
    description: Display("Obtenir des informations sur un joueur dans différents jeux"),
    subcommands: [
      BrawlStarsSub(),
    ],
  );
}

class BrawlStarsSub extends MineralSubcommand<GuildCommandInteraction> with Environment {
  BrawlStarsSub(): super(
    label: Display("brawl_stars"),
    description: Display("Obtenir des informations sur un joueur Brawl Stars"),
    options: [
      CommandOption.string(Display("identifiant"), Display("Identifiant du joueur (sans le #)"), required: true),
    ]
  );

  Future<void> handle(CommandInteraction command) async {
    String id = "#${command.getValue<String>("identifiant")}";

    Uri url = Uri.https('api.brawlstars.com', 'v1/players/${id}');
    http.Response response = await http.get(url, headers: { 'Authorization': 'Bearer ${environment.getOrFail('BRAWL_STARS_API_KEY')}' });
    Map<String, dynamic> body = json.decode(response.body);

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        await command.reply(content: "❌ Joueur avec comme identifiant `${id}` non trouvé...");
        return;
      } else {
        await command.reply(content: "❌ Une erreur inconnue est survenue... Veuillez réessayer ou prévenir notre équipe", private: true);
        return;
      }
    }

    int victories = body['3vs3Victories'] + body['soloVictories'] + body['duoVictories'];
    String club = body['club']['name'] ?? "*Aucun*";

    EmbedBuilder embed = EmbedBuilder(
      author: EmbedAuthor(name: "PeaBot - Profil", iconUrl: environment.getOrFail('ICON_URL')),
      color: Color(environment.getOrFail('COLOR')),
      description: """
      __Voici les informations Brawl Stars sur le joueur **${body['name']}** :__
      > - **Pseudo** → ${body['name']}
      > - **Trophées** → ${body['trophies']}
      > - **Nombre de victoires** → ${victories}
      > - **Tag** → ${body['tag']}
      > - **Club** → ${club}
      """,
      footer: EmbedFooter(text: "PeaBot | Profil", iconUrl: environment.getOrFail('ICON_URL')),
      timestamp: DateTime.now(),
      title: "Profil de ${body['name']}",
    );

    await command.reply(embeds: [embed]);
  }
}