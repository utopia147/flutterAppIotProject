import 'package:flutter/material.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Details/detail_sensor.dart';

class CategorySensor extends StatelessWidget {
  final int selectedMenu;
  CategorySensor({Key key, @required this.selectedMenu}) : super(key: key);
  List<String> category = [
    'DHT Temperature and Humidity',
    'Soil Moisture Sensor',
    'Voltage and Current Sensor voltage detection',
    'Ultrasonic Distance Measuring Transducer Sensor'
  ];
  List<String> sensor = [
    'DHT',
    'Soil Moisture',
    'Voltage detection',
    'Ultrasonic Distance'
  ];
  List<String> bgImage = [
    'images/dhtbg.jpg',
    'images/soilbg.jpg',
    'images/voltbg.jpg',
    'images/distanbg.png'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: MediaQuery.of(context).size.height /
                  1.120 /
                  MediaQuery.of(context).size.width),
          itemCount: category.length,
          itemBuilder: (BuildContext context, int index) {
            var bgimage = bgImage[index];
            var categorys = category[index];
            var sensors = sensor[index];
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return DetailSensor(
                    categorys: categorys,
                    bgimage: bgimage,
                    sensors: sensors,
                    selectedMenu: selectedMenu,
                  );
                }));
              },
              child: Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Flexible(
                      child: Hero(
                        tag: 'hero-tag-${bgimage}',
                        child: DecoratedBox(
                          child: Center(
                            child: Text(
                              '${category[index]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(
                                  '${bgimage}',
                                ),
                                fit: BoxFit.fill,
                                scale: 1,
                                alignment: Alignment.bottomCenter,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.srcOver)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
