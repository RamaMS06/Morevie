import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:lottie/lottie.dart';
import 'package:morevie/service/Config.dart';
import 'package:skeletons/skeletons.dart';

class TextComponent extends StatelessWidget {
  String label;
  Color? color;
  double? size;
  int? maxLines;
  FontWeight? weight;
  TextAlign? align;

  TextComponent(
      {Key? key,
      this.label = "",
      this.color = Colors.black,
      this.size = 14,
      this.maxLines = 4,
      this.align,
      this.weight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        textAlign: align,
        overflow: TextOverflow.ellipsis,
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

bottomNavBarComponent(IconData icons) =>
    BottomNavigationBarItem(icon: Icon(icons), label: '');

class SearchTextField extends StatelessWidget {
  Color? color;
  double? size;
  FontWeight? weight;
  Function(String) onChanged;
  Function(String)? onSubmit;
  SearchTextField(
      {this.color, this.onSubmit, required this.onChanged, this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.redAccent,
      onChanged: onChanged,
      onSubmitted: onSubmit,
      style: TextStyle(
        fontFamily: 'Poppins',
        color: color ?? Colors.black.withOpacity(0.8),
        fontSize: size ?? 14,
        fontWeight: weight ?? FontWeight.w500,
      ),
      decoration: InputDecoration(
          prefix: const SizedBox(width: 20),
          hintText: 'Search..',
          contentPadding: EdgeInsets.zero,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
              borderRadius: BorderRadius.circular(15)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}

class CardButton extends StatelessWidget {
  Color? cardColor;
  Color? shadowColor;
  Icon? cardIcon;
  VoidCallback callback;
  CardButton(
      {required this.callback,
      this.cardColor = Colors.white,
      this.shadowColor = Colors.black,
      this.cardIcon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 7.1,
      width: MediaQuery.of(context).size.width / 7.3,
      child: Card(
        shadowColor: shadowColor,
        elevation: 7,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5)),
        color: cardColor,
        child: InkWell(
          onTap: callback,
          child: Center(
            child: Center(child: cardIcon),
          ),
        ),
      ),
    );
  }
}

class NetworkImageMovie extends StatelessWidget {
  List listImage;
  String networkImage;
  NetworkImageMovie(
      {required this.listImage, required this.networkImage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      listImage.isEmpty
          ? 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734'
          : Config.baseImage + networkImage,
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? child
              : Skeleton(
                  isLoading: true,
                  skeleton: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        width: MediaQuery.of(context).size.width, height: 150),
                  ),
                  child: child),
      fit: BoxFit.cover,
    );
  }
}

class EmptyListComponent extends StatelessWidget {
  const EmptyListComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/lottie_empty.json',
            height: 180, width: 200, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: TextComponent(
              align: TextAlign.center,
              label: "The movie you are looking\nfor does not exist  :("),
        )
      ],
    );
  }
}

class CardTextComponent extends StatelessWidget {
  String label;
  VoidCallback? callback;
  Color? textColor;
  Color? bgColor;
  String assetIcon;
  CardTextComponent(
      {required this.label,
      required this.assetIcon,
      this.textColor,
      this.bgColor,
      this.callback,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(5)),
      shadowColor: Colors.redAccent,
      child: InkWell(
        onTap: callback,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/' + assetIcon, width: 15, height: 15),
              const SizedBox(width: 7.5),
              TextComponent(
                weight: FontWeight.w500,
                color: textColor,
                label: label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PoppinStyle extends TextStyle {
  PoppinStyle({Key? key});

  @override
  TextStyle build(BuildContext context) {
    return TextStyle(fontFamily: 'Poppins', color: color);
  }
}

class TextFormComponent extends StatelessWidget {
  String? hintText;
  String? label;
  IconData? icon;
  Function(String)? onChanged;
  Function()? onTap;
  Function(String)? onComplete;
  TextEditingController? controller;
  TextFormComponent(
      {this.hintText,
      this.label,
      this.icon,
      this.onChanged,
      this.onTap,
      this.controller,
      this.onComplete,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.redAccent,
      onChanged: onChanged,
      onFieldSubmitted: onComplete,
      onTap: onTap,
      style: PoppinStyle().copyWith(
          color: Colors.black.withOpacity(0.8),
          fontSize: 14,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          floatingLabelStyle: PoppinStyle().copyWith(color: Colors.redAccent),
          labelText: label,
          prefixIcon: icon == null ? null : Icon(icon, size: 20),
          labelStyle: PoppinStyle(),
          prefix: const SizedBox(width: 10),
          hintStyle:
              PoppinStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          hintText: hintText,
          contentPadding: const EdgeInsets.only(left: 10),
          focusColor: Colors.redAccent,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
