
import 'package:flutter/material.dart';

const String cloudyImage = 'assets/ex4/cloudy.png';
const String sunnyImage = 'assets/ex4/sunny.png';
const String sunnyCloudyImage = 'assets/ex4/sunnyCloudy.png';
const String veryCloudyImage = 'assets/ex4/veryCloudy.png';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF4F7FA),
        appBar: AppBar(
          backgroundColor: Color(0xFF263D5A),
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: Icon(Icons.menu),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            WeatherCard(
              city: 'Phnom Penh',
              minTemperature: 10,
              maxTemperature: 30,
              temperature: 12.2,
              image: cloudyImage,
              colors: [Color(0xFF536DFE), Color(0xFF7986CB)],
            ),
            WeatherCard(
              city: 'Paris',
              minTemperature: 10,
              maxTemperature: 40,
              temperature: 22.2,
              image: sunnyCloudyImage,
              colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
            ),
            WeatherCard(
              city: 'Rome',
              minTemperature: 10,
              maxTemperature: 40,
              temperature: 45.2,
              image: sunnyImage,
              colors: [Color(0xFFE65170), Color(0xFFFF8A80)],
            ),
            WeatherCard(
              city: 'Toulouse',
              minTemperature: 10,
              maxTemperature: 40,
              temperature: 45.2,
              image: veryCloudyImage,
              colors: [Color(0xFFEF8C35), Color(0xFFFFB74D)],
            ),
          ],
        ),
      ),
    ),
  );
}

class WeatherCard extends StatelessWidget {
  final String city;
  final double minTemperature;
  final double maxTemperature;
  final double temperature;
  final String image;
  final List<Color> colors;

  const WeatherCard({
    super.key,
    required this.city,
    required this.minTemperature,
    required this.maxTemperature,
    required this.temperature,
    required this.image,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 22),
      child: PhysicalModel(
        color: colors.first,
        elevation: 7,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -35,
                top: -35,
                bottom: -35,
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFF4F7FA),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ClipOval(
                          child: Image.asset(
                            image,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            city,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Min ${minTemperature.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Max ${maxTemperature.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${temperature.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
