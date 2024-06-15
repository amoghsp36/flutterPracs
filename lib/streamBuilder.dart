
import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilders extends StatefulWidget {
  const StreamBuilders({super.key});

  @override
  State<StreamBuilders> createState() => _StreamBuilderState();
}

class _StreamBuilderState extends State<StreamBuilders> {

  late Stream<int> _intStream;
  late StreamController<int> _streamController;
  Timer? _timer;
  bool _isPaused = false;
  int counter = 0;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController = StreamController<int>();
    _intStream = _streamController.stream;
   
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    _timer?.cancel();
    super.dispose();

  }

  void startCounter(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(!_isPaused){
        counter++;
        _streamController.sink.add(counter);
      }
      
    });
    
  }

  void stopCounter(){
    //_timer?.cancel();  //callinng cancel stops the callback func from being called
    _isPaused = !_isPaused;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('startnstopcounter'),
        actions: [
          IconButton(onPressed: stopCounter, icon: const Icon(Icons.pause)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: startCounter),
      body: StreamBuilder(stream: _intStream,initialData: _timer, builder: (context, snapshot){
        return Text('counter ${snapshot.data}');
      })
    );
  }
}