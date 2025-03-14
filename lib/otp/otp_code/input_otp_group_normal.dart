import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_service/otp/otp_code/input_otp_normal.dart';

enum InputOTPLength { four, six, eight }

class InputOTPGroupNormal extends StatefulWidget {
  const InputOTPGroupNormal({
    super.key,
    this.length = InputOTPLength.six,
    required this.onChanged,
    this.line = 2.0,
    this.lineColor,
    required this.textStyle,
    this.onTap,
    this.onKeyboard,
    this.value = '',
  });
  final String value;
  final double line;
  final Color? lineColor;
  final TextStyle textStyle;
  final InputOTPLength length;
  final FutureOr<void> Function(String) onChanged;
  final void Function()? onTap;
  final void Function(bool isShow)? onKeyboard;

  @override
  State<InputOTPGroupNormal> createState() => _InputOTPGroupNormalState();
}

class _InputOTPGroupNormalState extends State<InputOTPGroupNormal> {
  final TextEditingController _fieldInput = TextEditingController();

  String _otp = '';

  final _focusNode = FocusNode();

  

  late AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    _otp = widget.value;
    _fieldInput.text = _otp;
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onStateChange: (state) {},
      onResume: () {
        setState(() {
          _focusNode.requestFocus();
        });
      },
    );
    _focusNode.addListener((){
      widget.onKeyboard?.call(_focusNode.hasFocus);
    });
  }

  @override
  void didUpdateWidget(covariant InputOTPGroupNormal oldWidget) {
    super.didUpdateWidget(oldWidget);
    _otp = widget.value;
    _fieldInput.text = _otp;
    setState(() {
      
    });
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.dispose();
    _lifecycleListener.dispose();
    _fieldInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { 
        widget.onTap?.call();
        _focusNode.requestFocus();
      },
      child: StatefulBuilder(
        builder: (context, setState) {
          return LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 10.8;
              final count = widget.length == InputOTPLength.six
                  ? 6
                  : widget.length == InputOTPLength.eight
                      ? 8
                      : 4;
              final width = (constraints.maxWidth - (count - 1) * spacing) / count;
              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // auto focus
                      InputOTPNormal(
                        width: width,
                        line: widget.line,
                        textStyle: widget.textStyle,
                        lineColor: widget.lineColor,
                        selected: _fieldInput.text.isEmpty,
                        value: _getValueOfIndex(0),
                        onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      InputOTPNormal(
                        width: width,
                        line: widget.line,
                        textStyle: widget.textStyle,
                        lineColor: widget.lineColor,
                        selected: _fieldInput.text.length == 1,
                        value: _getValueOfIndex(1),
                        onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      InputOTPNormal(
                        width: width,
                        line: widget.line,
                        textStyle: widget.textStyle,
                        lineColor: widget.lineColor,
                        selected: _fieldInput.text.length == 2,
                        value: _getValueOfIndex(2),
                        onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                      ),
                      const SizedBox(
                        width: spacing,
                      ),
                      InputOTPNormal(
                        width: width,
                        line: widget.line,
                        textStyle: widget.textStyle,
                        lineColor: widget.lineColor,
                        selected: _fieldInput.text.length == 3,
                        value: _getValueOfIndex(3),
                        onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                      ),
                      if (widget.length == InputOTPLength.six || widget.length == InputOTPLength.eight) ...[
                        const SizedBox(
                          width: spacing,
                        ),
                        InputOTPNormal(
                          width: width,
                          line: widget.line,
                          textStyle: widget.textStyle,
                          lineColor: widget.lineColor,
                          selected: _fieldInput.text.length == 4,
                          value: _getValueOfIndex(4),
                          onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                        ),
                      ],
                      if (widget.length == InputOTPLength.six || widget.length == InputOTPLength.eight) ...[
                        const SizedBox(
                          width: spacing,
                        ),
                        InputOTPNormal(
                          width: width,
                          line: widget.line,
                          textStyle: widget.textStyle,
                          lineColor: widget.lineColor,
                          selected: _fieldInput.text.length == 5,
                          value: _getValueOfIndex(5),
                          onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                        ),
                      ],
                      if (widget.length == InputOTPLength.eight) ...[
                        const SizedBox(
                          width: spacing,
                        ),
                        InputOTPNormal(
                          width: width,
                          line: widget.line,
                          textStyle: widget.textStyle,
                          lineColor: widget.lineColor,
                          selected: _fieldInput.text.length == 6,
                          value: _getValueOfIndex(6),
                          onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                        ),
                      ],
                      if (widget.length == InputOTPLength.eight) ...[
                        const SizedBox(
                          width: spacing,
                        ),
                        InputOTPNormal(
                          width: width,
                          line: widget.line,
                          textStyle: widget.textStyle,
                          lineColor: widget.lineColor,
                          selected: _fieldInput.text.length == 7,
                          value: _getValueOfIndex(7),
                          onClicked: () { 
                          widget.onTap?.call();
                          _focusNode.requestFocus();
                        },
                        ),
                      ],
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Opacity(
                      opacity: 0,
                      child: TextField(
                        autofocus: true,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        controller: _fieldInput,
                        onTap: widget.onTap,
                        onChanged: (value) {
                          _otp = _fieldInput.text;
                          if (_otp.length ==
                              (widget.length == InputOTPLength.eight
                                  ? 8
                                  : widget.length == InputOTPLength.six
                                      ? 6
                                      : 4)) {}
                          widget.onChanged(_fieldInput.text);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          LengthLimitingTextInputFormatter(widget.length == InputOTPLength.eight
                                  ? 8
                                  : widget.length == InputOTPLength.six
                                      ? 6
                                      : 4),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  String _getValueOfIndex(int index) {
    if (index >= _otp.length) return '';
    return _otp.characters.characterAt(index).toString();
  }
}
