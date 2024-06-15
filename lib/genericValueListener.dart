

import 'package:flutter/foundation.dart';

class GenericsValueListener<T> extends ValueListenable<T>{
  GenericsValueListener(this.value);

  @override
  T value;

  final List<VoidCallback> _listeners = [];   //we need a list of voidcallback listeners as if a widget wants to know if the value it relies on has changed or not then it calls addListener, hence addListener must be included in the list as whenever a change happens the entire list is called to notify the changes to their widgets

  //@override
  T get getValue{
    return value;
  }

  set setValue(T newValue) {
    if (value == newValue) return;
    value = newValue;
    _notifyListeners();
  }
  @override
  void addListener(VoidCallback listener){  //we use @override here as addListener is an existing method in the ValueListenable interface(superclass) which our class here extends
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener){  //we are providing concrete implementations for these methods of superclass(ValueListenable)
    _listeners.remove(listener);
  }

  void _notifyListeners(){
    for(final listener in _listeners){
      listener();     //for every listener in the list we have to call the function so that they inturn notify the widgets which depend on the value the listeners are holding on to/listening to.
    }
  }
}  