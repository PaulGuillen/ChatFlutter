
import 'package:chat_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message = '', this.time = '', this.delivered, this.isMe, this.status = ''});

  final String message, time, status;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.white : MyColors.primaryColorLight;
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = status == 'ENVIADO' ? Icons.done : status == 'RECIBIDO' ? Icons.done_all : Icons.done_all;
    final radius = isMe
        ? BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(5.0),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
      bottomRight: Radius.circular(10.0),
    );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin:  EdgeInsets.only(right: isMe == true ? 3 : 70, left: isMe == true ? 70 : 3, top: 5, bottom: 5),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: isMe == true ? 60 : 57),
                child:  Text(message),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10.0,
                      )
                    ),
                    isMe == true ? Icon(
                      icon,
                      size: 12.0,
                      color: status == 'VISTO' ? Colors.blue : Colors.black38,
                    ) : Container()
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}