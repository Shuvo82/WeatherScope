import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/services/connectivity_check.dart';
import '../controllers/home_controller.dart';
import 'widgets/add_new_country.dart';
import 'widgets/weather_item_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Weather Scope ',
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              if (await ConnectivityCheck(context).checkInternetConnection()) {
                controller.getWeatherList();
              }
            },
            tooltip: 'Refresh',
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).splashColor,
              size: 25.0,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          //  print(controller.weatherDataListLoaded.isTrue);
          if (controller.isCityListEmpty.isTrue) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'No countries selected! Please add a country to view weather data.',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            );
          } else {
            if (controller.isWeatherDataListLoaded.isTrue) {
              return RefreshIndicator(
                onRefresh: () async {
                  if (await ConnectivityCheck(context)
                      .checkInternetConnection()) {
                    controller.getWeatherList();
                  }
                },
                child: ListView.separated(
                  itemCount: controller.weatherDataList.length + 1,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemBuilder: (context, index) {
                    if (index == controller.weatherDataList.length) {
                      return Center(
                        child: controller.weatherDataList.isEmpty
                            ? Text(
                                'No countries selected!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  color: Theme.of(context).hintColor,
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 100),
                                child: Text(
                                  'Press and hold to remove country!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                      );
                    } else {
                      return WeatherItemCard(
                        index: index,
                        controller: controller,
                      );
                    }
                  },
                ),
              );
            } else {
              return Center(
                child: SpinKitFadingCircle(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              );
            }
          }
        },
      ),

      floatingActionButton: AddNewCountry(controller: controller),
    );
  }
}
