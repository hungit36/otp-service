import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_service/otp_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 bool _isLimited = false;
 int _countTime = 0;
 late Timer _timer;
 String _error = '';
 String _otp = '';
 final _focusNode = FocusNode();
 
  @override
  void initState() {
    super.initState();
    _otp = '';
    _countTime = 60;
    _isLimited = false;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countTime == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _countTime--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OTP example'),
        ),
        body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OTPWidgetService( 
                        errorString: _error,
                        errorTextStyle: TextStyle(color: Colors.red[300]),
                        lineColor: Colors.black26,
                        onChanged: (otp) {
                          _otp = otp;
                          debugPrint('OTP: $otp');
                          setState(() {
                            _error = '';
                          });
                        }, 
                        textStyle: TextStyle(color: Colors.black, fontSize: 36),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(onPressed: (){
                        setState(() {
                          _error = _otp.isEmpty ? 'This is require.' : _otp.length < 6 ? 'The otp not validate.' : '';
                        });
                      }, 
                        child: Text("Verify Now")),
                      const SizedBox(height: 16),
                      if (_countTime > 0)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: _isLimited
                                      ? 'Resend limit reached. You can try again by resending the code in 24 hours ('
                                      : 'You can resend the code again in ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: _isLimited ? formatOTPTime : formatOTPTimeNotHour,
                                  style: TextStyle(color: Colors.black26)),
                              TextSpan(
                                  text: _isLimited ? ')s' : 's',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        )
                      else
                        OutlinedButton(onPressed: (){
                          _countTime = 60;
                            _startTimer();
                        }, child: Text("Resent code")),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildNoteWidget() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: _isLimited
                  ? 'Resend limit reached. You can try again by resending the code in 24 hours ('
                  : 'You can resend the code again in ',
              style: TextStyle(color: Colors.black),),
          TextSpan(
              text: _isLimited ? formatOTPTime : formatOTPTimeNotHour,
              style: TextStyle(color: Colors.black54)),
          TextSpan(
              text: _isLimited ? ')s' : 's',
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  String get formatOTPTime => _formatOTPTime();

  String get formatOTPTimeNotHour => _formatOTPTime(isFull: false);

  String _formatOTPTime({bool isFull = true}) {
    final duration = Duration(seconds: _countTime);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (isFull) hours, minutes, seconds].join(':');
  }
}
