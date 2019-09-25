import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  //state
  int _counter = 0;
  final _counterStateController = StreamController<int>();
  //for input data
  StreamSink<int> get _inCounter => _counterStateController.sink;
  // for state , output data
  Stream<int> get counter => _counterStateController.stream;

  ////////////////////
  ////////////////////
  ////////////////////

  final _counterEventController = StreamController<CounterEvent>();
  //for events
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  _mapEventToState(CounterEvent e) {
    if (e is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
