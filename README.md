# Weather Scope

Weather Scope is a weather forecasting application built with Flutter.

## App Information

- **App Name:** Weather Scope
- **Flutter Version:** 3.29.0
- **State Management:** GetX
- **Weather API Website:** [OpenWeatherMap](https://openweathermap.org/)
- **API URL with Keys:** [Weather API](https://api.openweathermap.org/data/2.5/weather?q=dhaka,bd&APPID=713c5bae5a4e237d71e3afef6e075d20)


## App Features
- **Weather Display**: All countries' weather will be shown in a list view.
- **Internet Connection Check**: The app will check the internet connection and handle necessary errors and validations.
- **Notifications**: All notifications will be shown on the snackbar.
- **Add Country**: You can add a new country. While adding a new country, it will validate whether the country has already been added and check if the country is valid by calling an API.
- **Remove Country**: You can remove a country by long pressing on the country name.
- **Pull to Refresh**: Pull to refresh functionality added for convenience.
- **Refresh Button**: Refresh button added to the app bar for easy access.

## Setup and Run the Project

- You have to clone the GitHub repository from this link “https://github.com/Shuvo82/WeatherScope”
- Then you have to make sure that Flutter 3.22.2 is installed on your computer. 
- Then write flutter pub get In the terminal. Make sure that you are in the projects directory in the terminal.

- Then you can run the project from the main.dart file.

## API Information

This application uses version 2.5 of the OpenWeatherMap API, as version 3.0 is a paid service.

- You have to go to this link “https://openweathermap.org/” then you have to sign in with your email.
- Then you have to verify your email by clicking a link sent to your email.
- Then you have to go to this link “https://home.openweathermap.org/api_keys” .Here you will get your API key.
- API documentation link “https://openweathermap.org/forecast5”
- The API sample will be like this “api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key} ”

This is all the documentation of my project. I hope you will like it.
