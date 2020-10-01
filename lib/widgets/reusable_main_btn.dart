import 'package:flutter/material.dart';
import 'package:photo/utils/size_config.dart';

class ReusableMainBtn extends StatelessWidget {
  const ReusableMainBtn({
    Key key,
    this.title,
    this.titleColor,
    this.onTap,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final Color titleColor;
  final Function onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: defaultSize * 19,
          margin: EdgeInsets.only(
            top: defaultSize * 2,
            bottom: defaultSize * 1,
          ),
          padding: EdgeInsets.symmetric(
            vertical: defaultSize * 1.8,
          ),
          decoration: (BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(defaultSize * 1),
            border: Border.all(width: 2),
          )),
          child: Text(title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: titleColor,
              ))),
    );
  }
}
