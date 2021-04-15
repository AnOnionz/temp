import 'package:flutter/material.dart';
import 'dart:html' as html;

class ErrorPage extends StatelessWidget {
  final bool is404;

  const ErrorPage({Key? key, this.is404 = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  is404 ? Image.asset(
                    'assets/images/404.png',
                    width: 800,
                  ) : Image.asset('assert/images/desktop.png'),
                  is404 ? ElevatedButton(
                      onPressed: () {
                        html.window.location.reload();
                      },
                      child: Text('Trang chủ')): Text('Thiết bị chưa được hỗ trợ'),
                ],
              ),
            )));
  }
}
