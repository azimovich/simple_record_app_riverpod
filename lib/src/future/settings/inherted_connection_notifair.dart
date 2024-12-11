import "package:flutter/widgets.dart";

import "connetion_controller.dart";

@immutable
class InhertedConnectionNotifair extends InheritedNotifier<ConnectionController> {
  const InhertedConnectionNotifair({
    required final ConnectionController connetionController,
    required super.child,
    super.key,
  }) : super(
          notifier: connetionController,
        );

  static ConnectionController? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<InhertedConnectionNotifair>()?.notifier;
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<InhertedConnectionNotifair>()?.widget;
      return inhW is InhertedConnectionNotifair ? inhW.notifier : null;
    }
  }
}
