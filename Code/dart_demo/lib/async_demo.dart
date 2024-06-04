import 'dart:isolate';

import 'package:async/async.dart';

void main(List<String> args) async {
  final ReceivePort receivePort = ReceivePort();
  Isolate.spawn(isolateWorker, receivePort.sendPort);

  final events = StreamQueue(receivePort);
  final SendPort sendPort = await events.next;

  await Future.delayed(Duration(seconds: 2));
  sendPort.send(100);

  final sum = await events.next;
  print("From spawn isolate, sum: $sum");
  events.cancel();
  Isolate.exit();
}

void isolateWorker(SendPort mainSendPort) async {
  final ReceivePort receivePort = ReceivePort();
  mainSendPort.send(receivePort.sendPort);

  final events = StreamQueue(receivePort);
  final int max = await events.next;
  final sum = await f(max);
  mainSendPort.send(sum);
  events.cancel();
  Isolate.exit();
}

// geneator
// event loop
Future<int> f(int max) async {
  int sum = 0;
  for (int i = 0; i < max; i++) {
    sum += i + 1;
  }

  return sum;
}
