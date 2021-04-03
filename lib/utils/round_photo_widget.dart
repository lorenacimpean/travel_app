import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class RoundPhotoWidget extends StatefulWidget {
  final AssetImage image;

  RoundPhotoWidget({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  State<RoundPhotoWidget> createState() => _RoundPhotoWidgetState();
}

class _RoundPhotoWidgetState extends State<RoundPhotoWidget> {
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  _loadImage() async {
    ByteData bd = await rootBundle.load(widget.image.assetName);
    Uint8List bytes = Uint8List.view(bd.buffer);
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.Image image = (await codec.getNextFrame()).image;
    setState(() => _image = image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        painter: PhotoPainter(_image),
      ),
    );
  }
}

class PhotoPainter extends CustomPainter {
  final ui.Image image;
  final Paint _paint;
  final Path _path;

  PhotoPainter(this.image, {Paint paint, Path path})
      : _paint = paint ?? Paint(),
        _path = path ?? Path();

  @override
  void paint(Canvas canvas, Size size) {
    _drawCanvas(size, canvas);
  }

  Canvas _drawCanvas(Size size, Canvas canvas) {
    _paint.style = PaintingStyle.fill;
    _paint.isAntiAlias = true;
    _path.moveTo(0, size.height * 0.3);
    _path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.30);
    _path.lineTo(size.width, 0);
    _path.lineTo(0, 0);
    canvas.clipPath(_path);
    canvas.drawPath(_path, _paint);
    canvas.drawImage(image, Offset(0, 0), _paint);
    return canvas;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
