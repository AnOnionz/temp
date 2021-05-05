import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sp_bill/features/statistic/presentation/widgets/util_btn.dart';
import '../../../../core/common/constants.dart';

class ImageView extends StatefulWidget {
  final List<String> images;

  const ImageView({Key key, @required this.images}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
   int _imgSelected = 0;
   int _rotate = 0;

  List<ImageItem> imageItems ;


  Future<ui.Image> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    var img = NetworkImage(path);
    img.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info,bool _){
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }
  @override
  void initState() {
    imageItems =
        widget.images.map((e) => ImageItem(url: e, rotate: 0)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          flex: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InteractiveViewer(
              child: RotatedBox(
                quarterTurns: imageItems[_imgSelected].rotate,
                child: Image.network(imageItems[_imgSelected].url,),
              ),
            ),
          )
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
                  icon: Image.asset(
                    'assets/images/back_img.png',
                    height: 22.5,
                  ),
                  callback: () {
                    setState(() {
                        _imgSelected =
                        _imgSelected > 0 ? _imgSelected - 1 : _imgSelected;
                        _rotate = 0;
                    });
                  },
                ),
                UtilButton(
                  icon: Image.asset(
                    'assets/images/left_rotate.png',
                    height: 22.5,
                  ),
                  callback: () {
                    setState(() {
                      _rotate--;
                      imageItems[_imgSelected].rotate = _rotate;
                    });
                  },
                ),
                UtilButton(
                  icon: Image.asset(
                    'assets/images/right_rotate.png',
                    height: 22.5,
                  ),
                  callback: () {
                    setState(() {
                      _rotate++;
                      imageItems[_imgSelected].rotate = _rotate;
                    });
                  },
                ),
                UtilButton(
                  icon: Image.asset(
                    'assets/images/next_img.png',
                    height: 22.5,
                  ),
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

  ImageItem({@required this.url, @required this.rotate});
}
