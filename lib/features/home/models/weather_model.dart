class WeatherModel {
  Coordinates? coordinates;
  List<WeatherCondition>? weatherConditions;
  String? baseStation;
  MainWeatherData? mainWeatherData;
  int? visibilityInMeters;
  WindData? windData;
  RainData? rainData;
  CloudData? cloudData;
  int? dataCalculationTime;
  SystemData? systemData;
  int? timezoneOffset;
  int? cityId;
  String? cityName;
  int? responseCode;

  WeatherModel({
    this.coordinates,
    this.weatherConditions,
    this.baseStation,
    this.mainWeatherData,
    this.visibilityInMeters,
    this.windData,
    this.rainData,
    this.cloudData,
    this.dataCalculationTime,
    this.systemData,
    this.timezoneOffset,
    this.cityId,
    this.cityName,
    this.responseCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      coordinates:
          json['coord'] != null ? Coordinates.fromJson(json['coord']) : null,
      weatherConditions: json['weather'] != null
          ? List<WeatherCondition>.from(
              json['weather'].map((x) => WeatherCondition.fromJson(x)))
          : null,
      baseStation: json['base'],
      mainWeatherData:
          json['main'] != null ? MainWeatherData.fromJson(json['main']) : null,
      visibilityInMeters: json['visibility'],
      windData: json['wind'] != null ? WindData.fromJson(json['wind']) : null,
      rainData: json['rain'] != null ? RainData.fromJson(json['rain']) : null,
      cloudData:
          json['clouds'] != null ? CloudData.fromJson(json['clouds']) : null,
      dataCalculationTime: json['dt'],
      systemData: json['sys'] != null ? SystemData.fromJson(json['sys']) : null,
      timezoneOffset: json['timezone'],
      cityId: json['id'],
      cityName: json['name'],
      responseCode: json['cod'],
    );
  }
}

class Coordinates {
  double? longitude;
  double? latitude;

  Coordinates({this.longitude, this.latitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      longitude: json['lon'].toDouble(),
      latitude: json['lat'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': longitude,
      'lat': latitude,
    };
  }
}

class WeatherCondition {
  int? conditionId;
  String? mainCondition;
  String? description;
  String? icon;

  WeatherCondition(
      {this.conditionId, this.mainCondition, this.description, this.icon});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      conditionId: json['id'],
      mainCondition: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': conditionId,
      'main': mainCondition,
      'description': description,
      'icon': icon,
    };
  }
}

class MainWeatherData {
  double? temperature;
  double? feelsLikeTemperature;
  double? minTemperature;
  double? maxTemperature;
  int? atmosphericPressure;
  int? humidity;
  int? seaLevelPressure;
  int? groundLevelPressure;

  MainWeatherData({
    this.temperature,
    this.feelsLikeTemperature,
    this.minTemperature,
    this.maxTemperature,
    this.atmosphericPressure,
    this.humidity,
    this.seaLevelPressure,
    this.groundLevelPressure,
  });

  factory MainWeatherData.fromJson(Map<String, dynamic> json) {
    return MainWeatherData(
      temperature: json['temp'].toDouble(),
      feelsLikeTemperature: json['feels_like'].toDouble(),
      minTemperature: json['temp_min'].toDouble(),
      maxTemperature: json['temp_max'].toDouble(),
      atmosphericPressure: json['pressure'],
      humidity: json['humidity'],
      seaLevelPressure: json['sea_level'],
      groundLevelPressure: json['grnd_level'],
    );
  }
}

class WindData {
  double? speed;
  int? direction;
  double? gustSpeed;

  WindData({this.speed, this.direction, this.gustSpeed});

  factory WindData.fromJson(Map<String, dynamic> json) {
    return WindData(
      speed: json['speed'].toDouble(),
      direction: json['deg'],
      gustSpeed: json['gust'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': direction,
      'gust': gustSpeed,
    };
  }
}

class RainData {
  double? oneHourVolume;

  RainData({this.oneHourVolume});

  factory RainData.fromJson(Map<String, dynamic> json) {
    return RainData(
      oneHourVolume: json['1h'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '1h': oneHourVolume,
    };
  }
}

class CloudData {
  int? cloudinessPercentage;

  CloudData({this.cloudinessPercentage});

  factory CloudData.fromJson(Map<String, dynamic> json) {
    return CloudData(
      cloudinessPercentage: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': cloudinessPercentage,
    };
  }
}

class SystemData {
  String? country;
  int? sunriseTime;
  int? sunsetTime;

  SystemData({this.country, this.sunriseTime, this.sunsetTime});

  factory SystemData.fromJson(Map<String, dynamic> json) {
    return SystemData(
      country: json['country'],
      sunriseTime: json['sunrise'],
      sunsetTime: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'sunrise': sunriseTime,
      'sunset': sunsetTime,
    };
  }
}
