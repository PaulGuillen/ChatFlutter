import 'package:chat_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BubbleVideo extends StatefulWidget {

  BubbleVideo({
    this.message = '',
    this.time = '',
    this.delivered,
    this.isMe,
    this.url = '',
    this.status = '',
    this.playVideo,
    this.videoController
  });

  final String message, time, url, status;
  final delivered, isMe;

  VideoPlayerController? videoController;
  ChewieController? chewieController;
  Function? playVideo;
  bool isLoading = false;

  @override
  State<BubbleVideo> createState() => _BubbleVideoState();
}

class _BubbleVideoState extends State<BubbleVideo> {

  @override
  Widget build(BuildContext context) {
    final bg = widget.isMe ? Colors.white : MyColors.primaryColorLight;
    final align = widget.isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = widget.status == 'ENVIADO' ? Icons.done : widget.status == 'RECIBIDO' ? Icons.done_all : Icons.done_all;
    final radius = widget.isMe
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
          margin:  EdgeInsets.only(right: widget.isMe == true ? 3 : 70, left: widget.isMe == true ? 70 : 3, top: 5, bottom: 5),
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
                padding: EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () => playVideo(),
                  child: Stack(
                    children: [

                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: widget.videoController?.value.isInitialized == true
                              ? AspectRatio(
                                aspectRatio: widget.videoController?.value.aspectRatio as double,
                                child: Chewie(
                              controller: widget.chewieController!,
                            ),
                          )
                              : _buildImageWait()
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(widget.time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    widget.isMe == true ? Icon(
                      icon,
                      size: 12.0,
                      color: widget.status == 'VISTO' ? Colors.blue : Colors.black38,
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

  Widget _buildImageWait() {
    return widget.isLoading == true
        ? Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Text('Cargando video...'),
    )
        : Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Icon(Icons.video_library, color: Colors.grey[600], size: 100),
    );
  }

  void playVideo() async {
    if (widget.videoController == null) {
      setState(() { widget.isLoading = true; });

      widget.videoController = VideoPlayerController.network(widget.url)..initialize().then((value) {

        widget.isLoading = false;

        widget.chewieController = ChewieController(
            videoPlayerController: widget.videoController!,
            autoPlay: true,
            looping: true
        );

        setState(() {});

      });
    }
    else if (widget.videoController?.value.isPlaying == true) {
      widget.videoController?.pause();
    }
    else {
      widget.videoController?.play();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.videoController?.dispose();
    widget.chewieController?.dispose();
    widget.videoController = null;
    widget.chewieController = null;
    widget.isLoading = false;
  }

}