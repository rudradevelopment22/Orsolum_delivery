import 'package:flutter/material.dart';
import 'package:orsolum_delivery/constant/color_const.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool? isBorder;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.padding,
    this.isBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConst.white,
        borderRadius: BorderRadius.circular(16),
        border:
            isBorder == true
                ? Border.all(color: ColorConst.neutralShade10)
                : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: child,
    );
  }
}
