
import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget{
  const MessageBubbles.first({
    super.key,
    required this.username,
    required this.userImage,     //we can have as many constructors as we want.
    required this.text,
    required this.isMe,
  }) : isPreviousSender = false;

  const MessageBubbles.next({
    super.key,
    required this.text,
    required this.isMe,
  }) : isPreviousSender = true,
       username = null,
       userImage = null;

  final String? username;
  final String? userImage;
  final String? text;
  final bool isPreviousSender;

  final bool isMe;

  @override
  Widget build(BuildContext build){
    return const Placeholder();
  }

}