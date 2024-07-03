import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_pages.dart';
import 'core/services/internet_connection_check_service.dart';
import 'core/services/theme_service.dart';

initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  await Get.putAsync<ConnectivityController>(
      () async => ConnectivityController());
  await Get.putAsync<ThemeService>(() async => ThemeService());
  Get.log('All services started...');
}

void _setInitialCountries() {
  final box = GetStorage();
  bool isFirstLaunch = box.read('isFirstLaunch') ?? true;
  if (isFirstLaunch) {
    List<String> countryList = [
      'Dhaka',
      'Tokyo',
      'London',
      'New York',
      'Paris',
      'Berlin',
      'Rome',
      'Moscow',
      'Madrid',
      'Vienna',
      'Amsterdam',
      'Brussels',
    ];
    box.write('COUNTRIES', countryList);
    box.write('isFirstLaunch', false);

    // 'Prague' , 'Stockholm' , 'Budapest' , 'Oslo' , 'Copenhagen' , 'Helsinki' , 'Dublin' , 'Lisbon' , 'Warsaw' , 'Athens' , 'Zurich' , 'Reykjavik' , 'Luxembourg' , 'Ljubljana' , 'Valletta' , 'Monaco'  , 'San Marino' , 'Vatican City' , 'Minsk' , 'Tirana' , 'Chisinau' , 'Yerevan' , 'Tbilisi' , 'Baku' , 'Bishkek' , 'Dushanbe' , 'Ashgabat' , 'Tashkent' , 'Nur-Sultan' , 'Astana' , 'Tehran' , 'Baghdad' , 'Jerusalem' , 'Amman' , 'Beirut' , 'Damascus' , 'Ankara' , 'Nicosia' , 'Cairo' , 'Riyadh'  , 'Doha' , 'Abu Dhabi' , 'Muscat' , 'Sanaa' , 'Manama' , 'Rabat' , 'Tunis' , 'Algiers' , 'Tripoli' , 'Khartoum' , 'Niamey' , 'Nouakchott' , 'Banjul' , 'Conakry' , 'Freetown' , 'Monrovia' , 'Bamako' , 'Ouagadougou' ,  'Yaounde' , 'Bangui' , 'Brazzaville' , 'Kinshasa' , 'Luanda' , 'Libreville' , 'Malabo' , 'Bata' , 'Lome' , 'Accra' , 'Abidjan' , 'Porto-Novo' , 'Cotonou' , 'Lagos' , 'Yaounde' , 'Douala' , 'Bamenda'
  }
}

void main() async {
  await initServices();
  _setInitialCountries();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: "Zaynax Weather Forecast",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.cupertino,
          theme: Get.find<ThemeService>().getLightTheme(),
          darkTheme: Get.find<ThemeService>().getDarkTheme(),
          themeMode: Get.find<ThemeService>().getThemeMode(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
