
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderForNetworkRequests extends StatefulWidget {
  const FutureBuilderForNetworkRequests({super.key});

  @override
  State<FutureBuilderForNetworkRequests> createState() => _FutureBuilderForNetworkRequestsState();
}

class _FutureBuilderForNetworkRequestsState extends State<FutureBuilderForNetworkRequests> {

  Future<Map<String,dynamic>> fetchhttpResponse() async {
    final resp2 = await http.get(Uri.parse('https://reqres.in/api/users/2')); //creating uri from string
    final resp = await http.get(Uri.https('reqres.in', 'api/users/2',)); //creating uri from https scheme -> creating uri meaning we locate those resources with the help of scheme or string
    if(resp.body.isNotEmpty && resp.statusCode == 200){
      return json.decode(resp.body);
    }else{
      throw Exception('Failed to fetch content');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: FutureBuilder(future: fetchhttpResponse(), builder: (content, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(!snapshot.hasData){
          return const Text('no data');
        }else if(snapshot.hasError){
          return Text('error occured- ${snapshot.error}');
        }else if(snapshot.hasData){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(snapshot.data!['data']['email']),
              Text(snapshot.data!['data']['id'].toString()),
              Text(snapshot.data!['data']['first_name']),
            ],
          );
        }
        else{
          return const Center(
            child: Text('All cases failed'),
          );
        }
      }),
    );
  }
}