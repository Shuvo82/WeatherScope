import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Weather Forecast',
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).splashColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              controller.getWeatherList();
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
          if (controller.isWeatherDataListLoaded.isTrue) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getWeatherList();
              },
              child: ListView.separated(
                itemCount: controller.weatherDataList.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemBuilder: (context, index) {
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
                                    controller.removeCountry(controller
                                            .weatherDataList[index].cityName ??
                                        'none');
                                    Get.snackbar(
                                      'Country removed!',
                                      'Weather data for ${controller.weatherDataList[index].cityName} will be removed shortly',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Get
                                          .theme.snackBarTheme.backgroundColor,
                                      colorText: Get
                                          .theme.snackBarTheme.actionTextColor,
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
                                        fontSize: 15.0,
                                        color: Theme.of(context).splashColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.weatherDataList[index].cityName ??
                                'none',
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).splashColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Temperature: ${controller.kelvinToCelsius(controller.weatherDataList[index].mainWeatherData!.temperature ?? 0)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).splashColor,
                                ),
                              ),
                              Text(
                                'Humidity: ${controller.weatherDataList[index].mainWeatherData!.humidity}%',
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
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
              ),
            );
          } else {
            return Center(
              child: SpinKitFadingCircle(
                color: Theme.of(context).splashColor,
                size: 50.0,
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 64, 7, 66),

        onPressed: () {
          // FocusScope.of(context).unfocus();
          // Show bottom sheet for adding country
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              TextEditingController _controller = TextEditingController();
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  // margin: EdgeInsets.only(top: 50, bottom: 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Enter country name',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add country to storage
                              controller.addCountry(_controller.text);
                              // Close the bottom sheet
                              // Navigator.pop(context);
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        //tooltip: 'Add new country.',

        label: Text(
          'Add Country',
          style: GoogleFonts.poppins(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).splashColor,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Theme.of(context).splashColor,
          size: 20.0,
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
