import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

class OnReady extends MineralEvent<ReadyEvent> with Console {
  @override
  Future<void> handle(ReadyEvent event) async {
    console.success("Connected as ${event.client.user.username}");
  }
}