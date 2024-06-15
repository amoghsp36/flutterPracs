
import 'package:flutter/material.dart';

class ValueListenerDemo extends StatefulWidget {
  const ValueListenerDemo({super.key});

  @override
  State<ValueListenerDemo> createState() => _ValueListenerState();
}

class _ValueListenerState extends State<ValueListenerDemo> {

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    _counter.removeListener(() { });
    // TODO: implement dispose
    super.dispose();
  }

  void increment(){
    
    _counter.value +=1;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('valueListener'),
      ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: _counter,
           builder: (BuildContext context, int value, Widget? child){
            return Text('$value');
           })),
      floatingActionButton: FloatingActionButton(tooltip: 'add', onPressed: increment, child: const Icon(Icons.add),),
      );
  }
}