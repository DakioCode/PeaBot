import 'package:mineral/core/api.dart';
import 'package:mineral/framework.dart';

class UptimeCMD extends MineralCommand {
  UptimeCMD()
      : super(label: Display("uptime"), description: Display("Obtenir mon uptime"));

  Future<void> handle(CommandInteraction command) async {
    DateTime uptime = command.client.uptime;
    await command.reply(content: "🕰️ Mon uptime actuel est de `${uptime.day} jour(s) ${uptime.hour} heure(s) ${uptime.minute} minutes et ${uptime.second} secondes`.");
  }
}
