import 'package:mineral/core.dart';
import 'package:mineral/core/services.dart';

import 'commands/blague.dart';
import 'commands/pileouface.dart';
import 'commands/profile.dart';
import 'commands/uptime.dart';
import 'events/ready.dart';
import 'managers/puissance4.dart';

void main () async {
  final kernel = Kernel(
    intents: IntentService(all: true),
    events: EventService([
      OnReady()
    ]),
    commands: CommandService([
      UptimeCMD(),
      BlagueCMD(),
      ProfileCMD(),
      PileOuFaceCMD(),
    ]),
  );

  await kernel.init();
}