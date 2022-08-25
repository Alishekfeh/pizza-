import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pizzafooddelivery/const/color.dart';
import 'package:pizzafooddelivery/const/icon_app.dart';
import 'package:pizzafooddelivery/pages/detail_page.dart';
import 'dart:math' as math;
import '../models/food_model.dart';
import '../widget/clip_path_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> foodList = FoodModel.list;
  PageController pageController = PageController(viewportFraction: 0.8);
  var paddingLeft=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: buildRightScreen(),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: AppColors.greenColor,
              width: 55,
              padding: EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image:
                                ExactAssetImage('assets/image/profile.jpg'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Center(child: Icon(FlutterIcons.menu)),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Transform.rotate(
                angle: -math.pi / 2,
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          buildMenu("Other",0),
                          buildMenu("vegetables",1),
                          buildMenu("beef",2),
                          buildMenu("chicken",3),

                          SizedBox(width: 30,)
                        ],
                      ),
                      AnimatedContainer(
                        duration: Duration(microseconds: 250),
                        width: 150,
                        height: 70,
                        margin: EdgeInsets.only(left: paddingLeft),
                        padding: EdgeInsets.only(right: 30,bottom: 35),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ClipPath(
                                clipper: AppClipper(),
                                child: Container(
                                  width: 200,
                                  height: 70,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ),
                            Align(
                              alignment:Alignment.center,
                              child: Transform.rotate(
                                  angle: math.pi / 2,
                                  child: Icon(
                                    FlutterIcons.arrow,
                                    size: 16,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu(String menu,int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          paddingLeft=index*150;
        });

      },
      child: Container(
          padding: EdgeInsets.only(
            top: 12,
            right: 35
          ),
          width: 150,
          child: Center(
              child: Text(
            menu,
            style: TextStyle(fontSize: 18),
          ))),
    );
  }

  SafeArea buildRightScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            _customAppBar(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 320,
                    child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: foodList.length,
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                              DetailPage(foodList[index])
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Stack(
                                children: [
                                  buildCardFood(index),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Transform.rotate(
                                      angle: math.pi / 3,
                                      child: Hero(
                                        tag: "image${foodList[index].imgPath}",
                                        child: Image(
                                          image: AssetImage(
                                              "assets/image/${foodList[index].imgPath}"),
                                          width: 170,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 10,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(70),
                                              bottomRight: Radius.circular(70)),
                                          color: Colors.red),
                                      child: Text(
                                        "\$  ${foodList[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      "Popular",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildPopularCard()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCardFood(int index) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 60, right: 25, bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SizedBox()),
          Row(
            children: [
              RatingBar.builder(
                initialRating: 2.5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 13,
                unratedColor: Colors.black12,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                onRatingUpdate: (rating) {
                  print('rating');
                },
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "(120 Reviews)",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${foodList[index].name}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCard() {
    return ListView.builder(
        padding: EdgeInsets.only(left: 40, bottom: 16, top: 20),
        itemCount: foodList.length,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )),
            child: Row(
              children: [
                Image(
                  width: 100,
                  height: 100,
                  image: AssetImage('assets/image/${foodList[index].imgPath}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodList[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${foodList[index].price.toInt()}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.redColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${foodList[index].weight.toInt()}gm weight",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

Widget _customAppBar() {
  return Container(
    child: Row(
      children: [
        SizedBox(width: 22,),
        RichText(
            text: TextSpan(
                text: "Hello\n",
                style: TextStyle(color: Colors.black),
                children: [
              TextSpan(
                  text: "Shadi  Weed ",
                  style: TextStyle(
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.bold,
                      height: 1.5))
            ])),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColors.greenLightColor),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "  Search"),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade100),
          child: Center(
            child: Icon(
              FlutterIcons.shop,
              size: 20,
            ),
          ),
        )
      ],
    ),
  );
}
