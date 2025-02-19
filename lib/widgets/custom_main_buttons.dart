import 'package:flutter/material.dart';

class CustomSignIn_UpThree extends StatelessWidget {
  CustomSignIn_UpThree({
    super.key,
    required this.title,
    this.customizeChild,
    this.ontap,
    this.color,
    this.textColor,
    this.padding
  });
  Color? color;
  Color? textColor;
  String title;
  Widget? customizeChild;
  void Function()? ontap;
  EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          surfaceTintColor: Colors.white,
          minimumSize:
          Size(MediaQuery.of(context).size.width, 55),
          maximumSize:
          Size(MediaQuery.of(context).size.width, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: color?? Colors.blue,
              width: 1.6
            ),
          ),
          backgroundColor: color?? Colors.white,
        ),
        onPressed: ontap,
        child: customizeChild??Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color:textColor?? Colors.blue,
          ),
        ),
      ),
    );
  }
}

class CustomSignIn_UpTwo extends StatelessWidget {
  CustomSignIn_UpTwo({
    super.key,
    required this.title,
    this.customizeChild,
    this.ontap,
    this.color,
    this.textColor,
  });
  Color? color;
  Color? textColor;
  String title;
  Widget? customizeChild;
  void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.white,
          minimumSize:
          Size(MediaQuery.of(context).size.width, 55),
          maximumSize:
          Size(MediaQuery.of(context).size.width, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: color?? Colors.blue[300]!,
            ),
          ),
          backgroundColor: color?? Colors.blue[300]!,
        ),
        onPressed: ontap,
        child: customizeChild??Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color:textColor?? Colors.blue,
          ),
        ),
      ),
    );
  }
}

class CustomSignIn_UpOne extends StatelessWidget {
  CustomSignIn_UpOne({
    super.key,
    required this.title,
    this.customizeChild,
    this.ontap,
    this.color,
    this.padding,
    this.shape,
    this.contentPadding
  });
  Color? color;
  String title;
  Widget? customizeChild;
  void Function()? ontap;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? contentPadding;
  OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding?? const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: contentPadding,
          surfaceTintColor: Colors.transparent,
          elevation: 5,
          minimumSize:
          Size(MediaQuery.of(context).size.width*0.6, 55),
          maximumSize:
          Size(MediaQuery.of(context).size.width*0.6, 55),
          shape:shape?? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          backgroundColor: color?? Colors.blue,
        ),
        onPressed: ontap,
        child: customizeChild??Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomSignIn_UpFour extends StatelessWidget {
  CustomSignIn_UpFour({
    super.key,
    required this.title,
    this.customizeChild,
    this.ontap,
    this.color,
    this.padding,
    this.shape,
    this.contentPadding
  });
  Color? color;
  String title;
  Widget? customizeChild;
  void Function()? ontap;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? contentPadding;
  OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding?? const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: contentPadding,
          surfaceTintColor: Colors.transparent,
          elevation: 5,
          minimumSize:
          Size(MediaQuery.of(context).size.width, 55),
          maximumSize:
          Size(MediaQuery.of(context).size.width, 55),
          shape:shape?? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: color?? Colors.blue,
        ),
        onPressed: ontap,
        child: customizeChild??Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}