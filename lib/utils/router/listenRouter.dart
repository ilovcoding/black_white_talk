export './listenRouter.dart';

import 'package:flutter/material.dart';

 buildRouter(BuildContext context) {
 return (Widget container, String route) {
    return Listener(
      child: container,
      onPointerDown: (e) {
        Navigator.pushNamed(context, route);
      },
    );
  };
}
