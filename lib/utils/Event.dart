import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class Event {
  static EventBus bus = new EventBus();
}

class EventHomeListItem {
  var data;
  EventHomeListItem(data);
}
