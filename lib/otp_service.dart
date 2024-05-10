import 'package:flutter/material.dart';
import 'package:otp_service/otp/otp_code/input_otp_group_normal.dart';

class OTPWidgetService extends StatefulWidget {
  const OTPWidgetService({
    super.key,
    required this.textStyle,
    this.line = 2,
    this.lineColor,
    this.errorString = '',
    this.errorTextStyle,
    required this.onChanged,
    this.length = InputOTPLength.six,
  });
  final InputOTPLength length;
  final TextStyle textStyle;
  final double line;
  final Color? lineColor;
  final String errorString;
  final TextStyle? errorTextStyle;
  final void Function(String) onChanged;

  @override
  State<OTPWidgetService> createState() => _WidgetState();
}

class _WidgetState extends State<OTPWidgetService> with SingleTickerProviderStateMixin {
  
  String _error = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _error = widget.errorString;
    });
  }

  @override
  void didUpdateWidget(covariant OTPWidgetService oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _error = widget.errorString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputOTPGroupNormal(
        line: widget.line,
        length: widget.length,
        lineColor: widget.lineColor,
        textStyle: widget.textStyle,
        onChanged: (otp) {
          resetError();
          widget.onChanged(otp);
        },
      ),
      if (_error.isNotEmpty) ...[
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.errorString,
            textAlign: TextAlign.left,
            style: widget.errorTextStyle,
          ),
        ),
      ]
      ],
    );
  }

  void resetError() {
    setState(() {
      _error = '';
    });
  }
}
