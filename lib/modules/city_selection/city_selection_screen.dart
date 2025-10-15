import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orsolum_delivery/common/back_button.dart';
import 'package:orsolum_delivery/common/background_container.dart';
import 'package:orsolum_delivery/constant/asset_const.dart';
import 'package:orsolum_delivery/constant/color_const.dart';
import 'package:orsolum_delivery/custom/custom_button.dart';
import 'package:orsolum_delivery/styles/text_style.dart';
import 'package:orsolum_delivery/utils/router_utils.dart';

class CitySelectionScreen extends StatelessWidget {
  const CitySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConst.primaryShade10, ColorConst.neutralShade5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.04, 0.1],
          ),
        ),
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: BackButtonWidget(),
                      ),
                    ),
                    Image.asset(AssetConst.orsolumTextLogo, height: 46),
                    Gap(54),
                  ],
                ),
                const Gap(24),
                Text("Select city to work", style: TextStyles.headline5),
                const Gap(30),
                BackgroundContainer(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              // controller: phoneController,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                hintText: "Search your work city",
                              ),
                              // onChanged: validateInput,
                            ),
                            const Gap(10),
                            Text("Popular Cities"),
                            Gap(10),
                            Row(
                              children: [
                                _popularCities(name: "Delhi", image: ""),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                Text("All Cities"),
                _cityList(),

                const Spacer(),
                CustomButton(
                  text: "Next",
                  onTap: () {
                    Get.toNamed(RouterUtils.selfieVerification);
                  },
                ),
                const Gap(30),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _cityList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _popularCities(name: "Delhi", image: "");
      },
    );
  }

  Widget _cityListTile() {
    return ListTile(leading: Image.asset(""), title: Text("Delhi"));
  }

  Widget _popularCities({required String name, required String image}) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // image: DecorationImage(image: NetworkImage("")),
            ),
          ),
          Gap(10),
          SizedBox(width: 60, child: Text(name)),
        ],
      ),
    );
  }
}
