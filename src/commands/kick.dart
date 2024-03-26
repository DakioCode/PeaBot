import 'package:mineral/core/api.dart';
import 'package:mineral/framework.dart';

class KickCMD extends MineralCommand {
  KickCMD()
      : super(
            label: Display("kick"),
            description: Display("Expulser un utilisateur du serveur"),
            options: [
              CommandOption.user(
                  Display("utilisateur"), Display("L'utilisateur à expulser"),
                  required: true),
              CommandOption.string(
                  Display("raison"), Display("La raison de l'expulsion"),
                  required: true)
            ]);

  Future<void> handle(CommandInteraction command) async {}
}
