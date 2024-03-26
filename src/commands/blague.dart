import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlagueCMD extends MineralCommand with Environment {
  BlagueCMD()
      : super(
          label: Display("blague"),
          description: Display("Raconter des blagues"),
        );

  Future<void> handle(CommandInteraction command) async {
    Uri url = Uri.https('www.blagues-api.fr', 'api/random');
    http.Response response = await http.get(url, headers: { 'Authorization': 'Bearer ${environment.getOrFail('BLAGUES_API_KEY')}' });
    Map<String, dynamic> body = json.decode(response.body);

    EmbedBuilder embed = EmbedBuilder(
      author: EmbedAuthor(name: "PeaBot - Blagues", iconUrl: environment.get('ICON_URL')),
      color: Color(environment.get('COLOR')),
      description: """
      __Voici une blague :__
      **${body['joke']}**
      ||${body['answer']}||
      """,
      footer: EmbedFooter(text: "PeaBot | Blagues", iconUrl: environment.get('ICON_URL')),
      timestamp: DateTime.now(),
      title: "Haha, une blague !",
    );
    await command.reply(embeds: [embed]);
  }
}
