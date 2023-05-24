import 'package:reservilla/data/models/contents/locations/locations_response.dart';
import 'package:reservilla/core/theme.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final List<Datum> city;

  const CityCard(this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        city.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 150,
              width: 120,
              color: Color(0xffF6F7F8),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/icons/city1.png',
                        width: 120,
                        height: 102,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            color: whitegreyColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/icon_star.png',
                              width: 22,
                              height: 22,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    city[index].name,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
