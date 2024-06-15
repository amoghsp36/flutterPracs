
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SimpleChatApp extends StatefulWidget {
  const SimpleChatApp({super.key});

  @override
  State<SimpleChatApp> createState() => _SimpleChatAppState();
}

class _SimpleChatAppState extends State<SimpleChatApp> {

  late Stream<List<String>> msg;
  late StreamController<List<String>> _streamController;

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final List<String> _messages = [];
  final List<String> _timestamps = [];

  final ValueNotifier<List<String>> _datetime = ValueNotifier<List<String>>([]); //we update the valueNotifier to a particular time, hence usinng a list, notifies the builder when the list updates

  Future<Map<String, dynamic>> fetchName() async {
    final resp = await http.get(Uri.parse('https://reqres.in/api/users/2')); // 
    if(resp.body.isNotEmpty && resp.statusCode == 200){
      return json.decode(resp.body);
    }
    else{
      throw Exception('Unknown error');
    }
  }

  @override
  void initState() {
    
    _streamController = StreamController<List<String>>();
    msg = _streamController.stream;
    super.initState();
  }

  @override
  void dispose() {
    
    _streamController.close();
    _controller.dispose();   //textController
    _datetime.dispose();  //valueNotifier
    super.dispose();
  }

  void sendmsg(){
    if(_formKey.currentState!.validate()){
      //setState(() {
        _messages.add(_controller.text);   //no need of calling setstate as streambuilder is listening to the list and the text is added to list, streambuilder will update the ui for us 
      //});
      _streamController.sink.add(_messages);
      //_counter.value+=1;
      _datetime.value = List.from(_messages);
      final currenTime = DateFormat('h:m').format(DateTime.now());  //since our list is of type String
      _timestamps.add(currenTime);
    }
    _controller.clear();
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('simpleChatApp')),
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Expanded(
        child: StreamBuilder<List<String>>(stream: msg, builder: (context, snapshot){  //snapshot gives us the latest value in the stream
        
          
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(!snapshot.hasData){
            return const Text('No Data');
          }
          else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          else{
            return FutureBuilder(future: fetchName(), builder: (context, snapshot2){
          if(snapshot2.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(!snapshot2.hasData){
            return Text('No data found ${snapshot2.error}');
          }else{
            return ValueListenableBuilder<List<String>>(valueListenable: _datetime, builder: (BuildContext context, List<String> values, Widget? child){
              
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,

              itemBuilder: (context, index){
              return ListTile(
                leading: Text('new message from ${snapshot2.data!['data']['first_name']} -'),
                title: Text(snapshot.data![index]),
                trailing: Text('at ${_timestamps[index]}'),
              );
            });
          
            });
          }
        });
      }
        }
      ),
      ),
       

      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    
                    decoration: const InputDecoration(
                      labelText: ' Send a message ',
                      border: InputBorder.none
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: false,
                    enableSuggestions: true,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter a message';
                      }
                      if(value.isNotEmpty && value.length > 20){
                        return 'msg length is restricted to 20 chars only';
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            IconButton(onPressed: sendmsg, icon: const Icon(Icons.send))
          ],
        ),
      )
        ],
      ),
    );
  }
}