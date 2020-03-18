import 'package:event_bus/event_bus.dart';


class Event {
  static EventBus bus = new EventBus();
}

class EventHomeListItem {
  var data;
  EventHomeListItem(this.data);
}

Stream eventStream = Event.bus.on<EventHomeListItem>();