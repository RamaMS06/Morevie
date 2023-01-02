import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:skeletons/skeletons.dart';

class TextComponent extends StatelessWidget {
  String label;
  Color? color;
  double? size;
  int? maxLines;
  FontWeight? weight;

  TextComponent(
      {Key? key,
      this.label = "",
      this.color = Colors.black,
      this.size = 14,
      this.maxLines = 4,
      this.weight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
            fontFamily: 'Poppins',
            color: color,
            fontSize: size,
            fontWeight: weight),
        maxLines: maxLines);
  }
}

class BoxTextComponent extends StatelessWidget {
  TextComponent? label;
  BoxTextComponent({this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.25)),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 7),
          child: label),
    );
  }
}

class CardComponent extends StatelessWidget {
  VoidCallback? pressed;
  double? elevation;
  double? radius;
  Color? colors;
  Widget content;
  CardComponent(
      {this.pressed,
      this.elevation = 7.5,
      this.radius = 25,
      this.colors,
      required this.content,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: pressed == null ? () {} : pressed!,
      duration: const Duration(milliseconds: 150),
      child: SizedBox(
        child: Card(
          color: colors,
          shadowColor: Colors.black.withOpacity(0.8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!)),
          elevation: elevation,
          child: content,
        ),
      ),
    );
  }
}

class SkeletonDefaultComponent extends StatelessWidget {
  bool isSkeleton;
  double? height;
  double? width;
  Widget child;
  SkeletonDefaultComponent(
      {required this.isSkeleton,
      this.height = 15,
      this.width = 48,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isLoading: isSkeleton,
        skeleton: SkeletonAvatar(
          style: SkeletonAvatarStyle(height: height, width: width),
        ),
        child: child);
  }
}
