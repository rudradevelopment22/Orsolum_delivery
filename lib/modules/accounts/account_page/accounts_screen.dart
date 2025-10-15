import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/modules/accounts/account_page/accounts_controller.dart';
import 'package:orsolum_delivery/modules/accounts/edit_profile/edit_profile_screen.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountPage extends GetView<AccountsController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text("Account", style: TextStyles.headline6),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // Profile Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/300",
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Obx(() {
                      final user = controller.currentUser;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.fullName.isNotEmpty
                                    ? controller.fullName
                                    : 'Guest User',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              if (!user.isVerified)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      Gap(4),
                                      Text("4.9"),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          if (user.phone.isNotEmpty) ...[
                            const Gap(4),
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 16),
                                const Gap(4),
                                Text(user.phone),
                              ],
                            ),
                          ],
                          if (user.email?.isNotEmpty ?? false) ...[
                            const Gap(2),
                            Row(
                              children: [
                                const Icon(Icons.email, size: 16),
                                const Gap(4),
                                Expanded(
                                  child: Text(
                                    user.email!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),

            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Options", style: TextStyles.headline6),
              ),
            ),
            const Gap(16),

            // Options
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildOptionTile(
                  title: "Edit Profile",
                  iconPath: AssetConst.user,
                  color: ColorConst.primary,
                  onTap: () {
                    Get.toNamed(RouterUtils.editProfile);
                  },
                ),
                const Gap(10),
                _buildOptionTile(
                  title: "Order History",
                  iconPath: AssetConst.list,
                  // icon: Icon(PhosphorIconsLight.notepad),
                  onTap: () {
                    Get.toNamed(RouterUtils.orderHistory);
                  },
                ),
                const Gap(10),
                _buildOptionTile(
                  title: "App Language",
                  iconPath: "assets/icons/language.svg",
                  icon: Icon(
                    PhosphorIconsRegular.translate,
                    size: 24,
                    color: ColorConst.primary,
                  ),
                  color: ColorConst.primary,
                  onTap: () {
                    Get.toNamed(RouterUtils.appLanguage);
                  },
                ),
                const Gap(10),
                _buildOptionTile(
                  title: "Order Alert Sound",
                  iconPath: "assets/icons/sound.svg",
                  icon: Icon(
                    PhosphorIconsRegular.speakerLow,
                    size: 24,
                    color: ColorConst.primary,
                  ),
                  color: ColorConst.primary,
                  onTap: () {},
                ),
                const Gap(10),
                // _buildOptionTile(
                //   title: "Support Language",
                //   iconPath: "assets/icons/help.svg",
                //   icon: Icon(
                //     PhosphorIconsRegular.questionMark,
                //     size: 24,
                //     color: ColorConst.primary,
                //   ),
                //   color: ColorConst.primary,
                //   onTap: () {
                //     Get.toNamed(RouterUtils.helpSupport);
                //   },
                // ),
                // const Gap(10),
                _buildOptionTile(
                  title: "Logout",
                  iconPath: AssetConst.logout,
                  color: Colors.red,
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              await controller.logout();
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
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
