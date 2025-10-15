import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';

class CashCollectionWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const CashCollectionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConst.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorConst.primaryShade15,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AssetConst.money,
                  color: ColorConst.primary,
                  height: 20,
                  width: 20,
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Cash Collection", style: TextStyles.headline6),
                        Spacer(),
                        Text("+249 ₹"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("2:50 PM", style: TextStyles.caption),
                        Spacer(),
                        Text(
                          "Collected",
                          style: TextStyles.caption.copyWith(
                            color: ColorConst.accentInfo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(6),
          _detailsTile("Transaction ID", "TNX - 12443212"),
          const Gap(4),
          _detailsTile("Date and Time", "Jan 15, 2025"),
        ],
      ),
    );
  }

  Widget _detailsTile(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyles.captionSemiBold.copyWith(
              color: ColorConst.grey400,
            ),
            maxLines: 1,
          ),
        ),
        const Gap(10),
        Text(
          value,
          style: TextStyles.subTitle2,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
