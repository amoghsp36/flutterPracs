
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:streambuilderexample/genericValueListener.dart';

class CustomValueListenableBuilderExample extends StatefulWidget {
  const CustomValueListenableBuilderExample({super.key});

  @override
  State<CustomValueListenableBuilderExample> createState() => _CustomValueListenableBuilderExampleState();
}

class _CustomValueListenableBuilderExampleState extends State<CustomValueListenableBuilderExample> {

  final GenericsValueListener<int> _counter = GenericsValueListener<int>(0);

  //ValueListenableBuilder widget takes care of adding and removing listeners to the CustomValueListenable object. This is why you don't see explicit calls to addListener in the _CustomValueListenableBuilderExampleState class.

  //So valuelistenablebuilder listenes to the genericValueListener
  //it automatically adds itself as a listener when it is first build

  void increment(){
    
    ValueListenable generic = GenericsValueListener(0);
    generic.addListener(() {_counter;});
    _counter.value+=1;
  }

  @override
  void dispose() {
    _counter.removeListener(() { }); //remove listener after it no longer listenes to updates
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('customValueListener'),
      ),
      body: Center(
        child: ValueListenableBuilder<int>(valueListenable: _counter, builder: (BuildContext context, int value, Widget? child){
          return Text('$value');
        })
      ),
      floatingActionButton: FloatingActionButton(onPressed: increment, tooltip: 'add here', child: const Icon(Icons.add),),
    );
  }
}