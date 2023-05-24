import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:reservilla/modules/controller/contents/profile_screen_controller.dart';
import 'package:reservilla/modules/controller/miscellaneous/dashboard_screen_controller.dart';
import 'package:reservilla/router/route_variables.dart';
import 'package:reservilla/widgets/confirmation_dialog.dart';
import 'package:reservilla/widgets/custom_icon_button.dart';
import 'package:reservilla/widgets/error_state.dart';
import 'package:reservilla/widgets/profile_section_button.dart';
import 'package:reservilla/widgets/skeleton_loader.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenController controller = Get.find<ProfileScreenController>();
  DashboardScreenController dashboardScreenController = Get.find<DashboardScreenController>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: contextOrange,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                  )
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Aktivitas Saya',
                          style: h5(color: contextOrange),
                        ),
                      ),
                      ProfileSectionButton(
                        onTap: () {

                        }, 
                        icon: Icons.favorite_rounded, 
                        buttonText: 'Favorit'
                      ),
                      ProfileSectionButton(
                        onTap: () {

                        },
                        icon: Icons.reviews_rounded,
                        buttonText: 'Ulasan',
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Profil',
                          style: h5(color: contextOrange),
                        ),
                      ),
                      ProfileSectionButton(
                        onTap: () {

                        }, 
                        icon: Icons.edit_note, 
                        buttonText: 'Ubah Profil'
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Lainnya',
                          style: h5(color: contextOrange),
                        ),
                      ),
                      ProfileSectionButton(
                        onTap: () {
                          Get.dialog(
                            ConfirmationDialog(
                              title: 'Tunggu sebentar!', 
                              content: 'Apakah Anda yakin ingin keluar dari akun Anda?', 
                              onConfirmation: () async {
                                await controller.logout();
                                Get.offAllNamed(loginScreenRoute);
                              }
                            )
                          );
                        }, 
                        icon: Icons.logout_rounded, 
                        buttonText: 'Keluar Akun'
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: Obx(() => dashboardScreenController.userLoading ? Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const SkeletonLoader()
                ) : dashboardScreenController.user == null ? Column(children: [ 
                    ErrorState(
                        iconSize: 50, 
                        color: contextGrey, 
                        textStyle: h4(color: Colors.white)
                      ),
                      const SizedBox(height: 5),
                      CustomIconButton(
                        onTap: () {
                          dashboardScreenController.getUserById();
                        }, 
                        radius: 15, 
                        icon: Icons.refresh,
                        borderColor: Colors.white,
                        iconColor: Colors.white,
                      )
                    ],
                  ) : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Obx(() {
                        if (dashboardScreenController.user!.data.profilePicture == null) {
                          return const Icon(
                            Icons.account_circle_rounded,
                            color: backgroundColorPrimary,
                            size: 100,
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: CachedNetworkImage(
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.width / 4,
                              imageUrl: baseUrlImg + dashboardScreenController.user!.data.profilePicture,
                              fadeInDuration: const Duration(milliseconds: 300),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              placeholder: (context, url) => const SpinKitThreeBounce(
                                color: contextOrange,
                                size: 18
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: MediaQuery.of(context).size.height / 6,
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dashboardScreenController.user!.data.name,
                            style: h4(color: backgroundColorLight),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            dashboardScreenController.user!.data.email,
                            style: bodyMd(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '0${dashboardScreenController.user!.data.phone}',
                            style: bodyMd(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}