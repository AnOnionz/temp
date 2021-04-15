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
  late int _rotate = 0;
  final GlobalKey<ExtendedImageEditorState> editorKey =GlobalKey<ExtendedImageEditorState>();

  late List<ImageItem> imageItems =
      widget.images.map((e) => ImageItem(url: e, rotate: 0)).toList();
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
              var path = imageItems[index].url;
              Widget image = RepaintBoundary(
                  child: RotatedBox(
                quarterTurns: imageItems[_imgSelected].rotate,
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
                ),
              ));
              image = Container(
                child: image,
                padding: EdgeInsets.all(5.0),
              );
              return Hero(
                tag: path,
                  child: image);
            },
            itemCount: imageItems.length,
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
                '${_imgSelected + 1}/${imageItems.length}',
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
                        _rotate = 0;
                      });
                    });
                  },
                ),
                UtilButton(
                  icon: Icon(Icons.rotate_left_outlined, size: 25,),
                  callback: () {
                    setState(() {
                      editorKey.currentState!.rotate(right: false);
                      imageItems[_imgSelected].rotate = _rotate;
                    });
                  },
                ),
                UtilButton(
                  icon: Icon(Icons.rotate_right_outlined,size: 25,),
                  callback: () {
                    setState(() {
                     editorKey.currentState!.rotate(right: true);
                      imageItems[_imgSelected].rotate = _rotate;
                    });
                  },
                ),
                UtilButton(
                  icon: Icon(Icons.arrow_forward_ios_outlined, size: 25,),
                  callback: () {
                    setState(() {
                      _imgSelected = _imgSelected < imageItems.length - 1
                          ? _imgSelected + 1
                          : _imgSelected;
                      _rotate = 0;
                    });
                  },
                ),
              ],
            )),
      ],
    );
  }
}

class ImageItem {
  final String url;
  int rotate;

  ImageItem({required this.url, required this.rotate});
}
