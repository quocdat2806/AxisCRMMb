import 'dart:async';

abstract class AppEvent {}

/// Event fired when worker info or status is updated.
class WorkerUpdatedEvent extends AppEvent {}

/// Event fired when a worker advance is created or updated.
class AdvanceUpdatedEvent extends AppEvent {}

/// Event fired when attendance/worksheet records are created or updated.
class WorksheetUpdatedEvent extends AppEvent {}

/// Event fired when a project is created.
class ProjectCreatedEvent extends AppEvent {}

class EventBus {
  final StreamController<AppEvent> _controller = StreamController<AppEvent>.broadcast();

  /// Listen to a specific type of Event.
  Stream<T> on<T extends AppEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  /// Fire an Event.
  void fire(AppEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  /// Close the Event Bus.
  void dispose() {
    _controller.close();
  }
}
