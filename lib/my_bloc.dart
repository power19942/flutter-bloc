import 'dart:async';

class MyCounterBloc{
  int counter = 0;
  final controller = StreamController<int>();
  StreamSink<int> get controller_sink => controller.sink;
  Stream<int> get data => controller.stream;
  final counterEventController = StreamController<int>();
  Sink<int> get counter_event_sink => counterEventController.sink;


  MyCounterBloc(){
    counterEventController.stream.listen(onAdd);
  }

  onAdd(int number){
    controller_sink.add(++counter);
  }

  dispose(){
    controller.close();
    counterEventController.close();
  }
}

/////////////////////////////////////
/////////////////////////////////////
/////////////////////////////////////
abstract class CounterEvent{}

class IncrementEvent extends CounterEvent{}

class CounterBLoC{

  int _counter = 0;

  // init and get StreamController
  final _counterStreamController = StreamController<int>();
  StreamSink<int> get counter_sink => _counterStreamController.sink;

  // expose data from stream
  Stream<int> get stream_counter => _counterStreamController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  // expose sink for input events
  Sink <CounterEvent> get counter_event_sink => _counterEventController.sink;

  CounterBLoC() {  _counterEventController.stream.listen(_count);  }


  _count(CounterEvent event) => counter_sink.add(++_counter);

  dispose(){
    _counterStreamController.close();
    _counterEventController.close();
  }
}