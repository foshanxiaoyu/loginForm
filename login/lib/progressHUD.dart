import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  ProgressHUD(
      {super.key,
      required this.child,
      required this.inAsyncCall,
      this.opacity = 0.3,
      this.color = Colors.grey,
      this.valueColor
      // = ColorTween.lerp(Colors.red, Colors.blue, 0.5),
      });

  @override
  Widget build(BuildContext context) {
// 定义一个Widget的List
    List<Widget> widgetList = List.empty();

    // List<Widget> widgetList =  List<dynamic>();
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(child: new CircularProgressIndicator()),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
