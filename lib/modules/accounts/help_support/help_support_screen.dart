import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Help & Support", style: TextStyles.headline6),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          children: [
            _buildOptionTile(
              title: "Account and Profile issues",
              icon: PhosphorIcon(
                PhosphorIconsFill.userCircle,
                size: 24,
                color: ColorConst.primary,
              ),
              onTap: () {},
              color: Colors.blue,
            ),
            _buildOptionTile(
              title: "Delivery related issues",
              icon: Icon(
                PhosphorIconsRegular.package,
                size: 24,
                color: ColorConst.primary,
              ),
              onTap: () {},
              color: Colors.blue,
            ),
            _buildOptionTile(
              title: "Payment and Earnings",
              icon: Icon(
                PhosphorIconsRegular.wallet,
                size: 24,
                color: ColorConst.primary,
              ),
              onTap: () {},
              color: Colors.blue,
            ),
            _buildOptionTile(
              title: "App technical issues",
              icon: Icon(
                PhosphorIconsRegular.gearSix,
                size: 24,
                color: ColorConst.primary,
              ),
              onTap: () {},
              color: Colors.blue,
            ),
            _buildOptionTile(
              title: "Emergency support",
              icon: Icon(
                PhosphorIconsRegular.warning,
                size: 24,
                color: ColorConst.primary,
              ),
              onTap: () {},
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    String? iconPath,
    Icon? icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: BackgroundContainer(
        child: Row(
          children: [
            if (icon != null)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: Colors.black12),
                ),
                child: icon,
              )
            else if (iconPath != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  iconPath,
                  height: 24,
                  width: 24,
                  color: color,
                ),
              ),
            const Gap(10),
            Expanded(
              child: Text(
                title,
                style: TextStyles.subTitle1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(10),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
