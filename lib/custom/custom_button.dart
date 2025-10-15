import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/utils/enum.dart';

import '../../constant/color_const.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Size? size;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? disableColor;
  final EdgeInsets? margin;
  final BorderSide? side;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  late final Rx<ApiStatus> _status;

  CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.size,
    this.backgroundColor,
    this.textColor,
    this.disableColor,
    this.margin,
    this.side,
    this.borderRadius,
    this.textStyle,
    Rx<ApiStatus>? loadingStatus,
  }) {
    _status = loadingStatus ?? Rx(ApiStatus.none);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Obx(() {
        final showLoader = _status.value == ApiStatus.loading;
        return ElevatedButton(
          onPressed: showLoader ? null : onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            disabledBackgroundColor: disableColor,
            foregroundColor: textColor,
            minimumSize: size,
            shape:
                borderRadius != null
                    ? RoundedRectangleBorder(borderRadius: borderRadius!)
                    : null,
            side: side,
          ),
          child:
              showLoader
                  ? SizedBox(
                    height: 18,
                    width: 18,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        ColorConst.primary,
                        BlendMode.srcATop,
                      ),
                      child: const CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                  : Text(text, style: textStyle),
        );
      }),
    );
  }
}
