import 'dart:async';

import 'package:flutter/material.dart';

class InputOTPNormal extends StatefulWidget {
  const InputOTPNormal({
    super.key,
    required this.value,
    required this.onClicked,
    required this.selected,
    this.line = 2.0,
    this.lineColor,
    required this.textStyle,
    required this.width,
    this.height = 70.0,
  });
  final double height;
  final double width;
  final double line;
  final Color? lineColor;
  final TextStyle textStyle;
  final bool selected;
  final String value;
  final FutureOr<void> Function() onClicked;

  @override
  State<InputOTPNormal> createState() => _InputOTPNormalState();
}

class _InputOTPNormalState extends State<InputOTPNormal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClicked(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: widget.lineColor ??
                  widget.textStyle.color?.withOpacity(0.75) ?? Colors.transparent,
              width: widget.line,
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 10),
        height: widget.height,
        width: widget.width,
        child: Center(
          child: Text(
            widget.value,
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
