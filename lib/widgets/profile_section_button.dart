import 'package:flutter/material.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/core/font_sizes.dart';

class ProfileSectionButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final String buttonText;
  
  const ProfileSectionButton({
    super.key, 
    required this.onTap,
    required this.icon, 
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Icon(
                icon,
                color: contextGrey,
                size: 30,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buttonText,
                            style: h4_5(
                              color: contextOrange,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: contextGrey, 
                            size: 20
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: backgroundColorPrimary,
                      thickness: 1,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}