import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaynax_weather_forecast/core/services/connectivity_check.dart';
import 'package:zaynax_weather_forecast/features/home/controllers/home_controller.dart';

class AddNewCountry extends StatelessWidget {
  const AddNewCountry({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () async {
        // FocusScope.of(context).unfocus();
        // Show bottom sheet for adding country

        if (await ConnectivityCheck(context).checkInternetConnection()) {
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // margin: EdgeInsets.only(top: 50, bottom: 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Enter country name',
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: Theme.of(context).splashColor,
                          )),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).hoverColor,
                              ),
                            ),
                            child: Text('Cancel',
                                style: TextStyle(
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Add country to storage

                              if (await ConnectivityCheck(context)
                                  .checkInternetConnection()) {
                                controller.addCountry(_controller.text);
                              }

                              // Close the bottom sheet
                              // Navigator.pop(context);
                            },
                            child: Text('Save',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
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
    );
  }
}
