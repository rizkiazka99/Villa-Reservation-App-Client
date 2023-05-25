import 'package:get/get.dart';
import 'package:reservilla/core/colors.dart';
import 'package:reservilla/data/models/contents/locations/locations_response.dart';
import 'package:reservilla/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:reservilla/router/route_variables.dart';

class CityCard extends StatelessWidget {
  final List<Datum> city;

  const CityCard(this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(right: 16),
      children: List.generate(
        city.length,
        (index) => InkWell(
          onTap: () {
            Get.toNamed(
              locationDetailScreenRoute,
              arguments: {
                'id': city[index].id,
                'location_name': city[index].name
              }
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 150,
                width: 120,
                color: contextOrange,
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
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        city[index].name,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
