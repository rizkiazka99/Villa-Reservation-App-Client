import 'package:reservilla/modules/view/home/models/city.dart';
import 'package:reservilla/modules/view/home/models/space.dart';
import 'package:reservilla/modules/view/home/models/tips.dart';
import 'package:reservilla/modules/view/home/theme.dart';
import 'package:reservilla/modules/view/home/widgets/city_card.dart';
import 'package:reservilla/modules/view/home/widgets/space_card.dart';
import 'package:reservilla/modules/view/home/widgets/tips_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Space space = Space(
        city: "city",
        country: "country",
        id: 1,
        imageUrl:
            "https://blue.kumparan.com/image/upload/v1634025439/01gcjys1yc8kdy5b6pprnt9j5w.jpg",
        name: "name",
        price: 1000000,
        rating: 3,
        address: "address",
        mapUrl: "mapUrl",
        numberOfBedrooms: 2,
        numberOfCupboards: 1,
        numberOfKitchens: 1,
        phone: "phone",
        photos: [
          "https://blue.kumparan.com/image/upload/v1634025439/01gcjys1yc8kdy5b6pprnt9j5w.jpg",
          "https://blue.kumparan.com/image/upload/v1634025439/01gcjys1yc8kdy5b6pprnt9j5w.jpg",
          "https://blue.kumparan.com/image/upload/v1634025439/01gcjys1yc8kdy5b6pprnt9j5w.jpg",
          "https://blue.kumparan.com/image/upload/v1634025439/01gcjys1yc8kdy5b6pprnt9j5w.jpg"
        ]);
    // var spaceProvider = Provider.of<SpaceProvider>(context);
    List<Widget> widgets = [];

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            SizedBox(
              height: edge,
            ),
            // NOTE: TITLE/HEADER
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Explore Now',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Mencari Villa yang cozy',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // NOTE: POPULAR CITIES
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Popular Cities',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  CityCard(
                    City(
                      id: 1,
                      name: 'Jakarta',
                      imageUrl: 'assets/city1.png',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CityCard(
                    City(
                      id: 2,
                      name: 'Bandung',
                      imageUrl: 'assets/city2.png',
                      isPopular: true,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CityCard(
                    City(
                      id: 3,
                      name: 'Surabaya',
                      imageUrl: 'assets/city3.png',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CityCard(
                    City(
                      id: 4,
                      name: 'Palembang',
                      imageUrl: 'assets/city4.png',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CityCard(
                    City(
                      id: 5,
                      name: 'Aceh',
                      imageUrl: 'assets/city5.png',
                      isPopular: true,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CityCard(
                    City(
                      id: 6,
                      name: 'Bogor',
                      imageUrl: 'assets/city6.png',
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // NOTE: RECOMMENDED SPACE
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Recommended Space',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge),
              child: Column(
                children: [
                  SpaceCard(space),
                  SpaceCard(space),
                  SpaceCard(space),
                  SpaceCard(space),
                  SpaceCard(space),
                  SpaceCard(space),
                  SpaceCard(space),
                  SpaceCard(space),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // NOTE: TIPS & GUIDANCE
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Tips & Guidance',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: edge,
              ),
              child: Column(
                children: [
                  TipsCard(
                    Tips(
                      id: 1,
                      title: 'City Guidelines',
                      imageUrl: 'assets/tips1.png',
                      updatedAt: '20 Apr',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TipsCard(
                    Tips(
                      id: 2,
                      title: 'Jakarta Fairship',
                      imageUrl: 'assets/tips2.png',
                      updatedAt: '11 Dec',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100 + edge,
            ),
          ],
        ),
      ),
    );
  }
}
