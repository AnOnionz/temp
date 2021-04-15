import 'dart:async';
import 'dart:ui' as ui;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/util_btn.dart';
import '../../../../core/common/constants.dart';

class ImageView extends StatefulWidget {
  final List<String> images;

  const ImageView({Key? key, required this.images}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late int _imgSelected = 0;
  final GlobalKey<ExtendedImageEditorState> editorKey =GlobalKey<ExtendedImageEditorState>();

  @override
  void dispose() {
    clearMemoryImageCache();
    clearGestureDetailsCache();
    super.dispose();
  }

  Future<ui.Image> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    var img = new NetworkImage(path);
    img.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info,bool _){
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 20,
          child: ExtendedImageGesturePageView.builder(
            canScrollPage: (gestureDetails) => false,
            canMovePage: (gestureDetails) => false,
            itemBuilder: (BuildContext context, int index) {
              index = _imgSelected;
              var path = widget.images[index];
              Widget image = RepaintBoundary(
                  child: ExtendedImage.network(
                    path,
                    cache: true,
                    imageCacheName: '$path',
                    initGestureConfigHandler: (state) {
                      return GestureConfig(
                        cacheGesture: true,
                      );
                    },
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    extendedImageEditorKey: editorKey,
                    enableMemoryCache: true,
                    enableLoadState: true,
                  ));
              image = Container(
                child: image,
                padding: EdgeInsets.all(5.0),
              );
              return Hero(
                tag: path,
                  child: image);
            },
            itemCount: widget.images.length,
            controller: PageController(
              initialPage: _imgSelected,
              keepPage: true,
            ),
            scrollDirection: Axis.horizontal,
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${_imgSelected + 1}/${widget.images.length}',
                style: kBlackBigText,
              ),
            )),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UtilButton(
                  icon: Icon(Icons.arrow_back_ios_outlined, size: 25,),
                  callback: () {
                    setState(() {
                      setState(() {
                        _imgSelected =
                            _imgSelected > 0 ? _imgSelected - 1 : _imgSelected;
                      });
                    });
                  },
                ),
                UtilButton(
                  icon: Icon(Icons.rotate_left_outlined, size: 25,),
                  callback: () {
                    setState(() {
                      editorKey.currentState!.rotate(right: false);
                    });
                  },
                ),
                UtilButton(
                  icon: Icon(Icons.rotate_right_outlined,size: 25,),
                  callback: () {
                    setState(() {
                     editorKey.currentState!.rotate(right: true);
                    });
                  },
                ),
                UtilButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined, size: 25,),
                  callback: () {
                    setState(() {
                      _imgSelected = _imgSelected < widget.images.length - 1
                          ? _imgSelected + 1
                          : _imgSelected;

                    });
                  },
                ),
              ],
            )),
      ],
    );
  }
}

