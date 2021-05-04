import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final Widget icon;
  final Widget onActive;
  final VoidCallback onPressed;

  const HoverButton({Key key,@required this.icon,@required this.onActive, @required this.onPressed}) : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
   bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) => setState(() => _hover = true),
        onTapUp: (_) => setState(() => _hover = false),
        onTapCancel: () => setState(() => _hover = false),
        child: MouseRegion(
          onHover: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          child: TextButton(onPressed: widget.onPressed,
            child: _hover ? widget.onActive : widget.icon,
              style: TextButton.styleFrom(
                  minimumSize: Size(40,40)
              ),),
        )
    );
  }
}
