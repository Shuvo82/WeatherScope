import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../core/api_controller/api_url.dart';
import '../../controllers/home_controller.dart';

class WeatherItemCard extends StatelessWidget {
  final int index;
  const WeatherItemCard({
    super.key,
    required this.index,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Remove: ${controller.weatherDataList[index].cityName}?',
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      controller.removeCountry(
                          controller.weatherDataList[index].cityName ?? 'none');
                      Get.snackbar(
                        'Country removed!',
                        'Weather data for ${controller.weatherDataList[index].cityName} removed successfully.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor:
                            Get.theme.snackBarTheme.backgroundColor,
                        colorText: Colors.white,
                      );
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).hoverColor,
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          fontSize: 15.0, color: Theme.of(context).splashColor),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.weatherDataList[index].cityName ?? 'none',
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Temperature: ${controller.kelvinToCelsius(controller.weatherDataList[index].mainWeatherData!.temperature ?? 0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).splashColor,
                  ),
                ),
                Text(
                  'Humidity: ${controller.weatherDataList[index].mainWeatherData!.humidity ?? 0}%',
                  style: GoogleFonts.poppins(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).splashColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  '${ApiClient.iconUrl}${controller.weatherDataList[index].weatherConditions![0].icon}@2x.png',
                  height: 80,
                  width: 80,
                ),
                Text(
                  controller.weatherDataList[index].weatherConditions![0]
                          .mainCondition ??
                      'none',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).splashColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
