import 'package:geolocator/geolocator.dart';

class GetLocation{
    double latitude;
    double longitude;
    String city;

    // Get current Location
    Future<void> getCurrentLocation() async{
        try{
            Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best); // current location from mobile (await from geolocator)
            latitude = position.latitude;
            longitude = position.longitude;

            city = await getCityName(position.latitude, position.longitude);  // await from getCityName Fun
        }
        catch(e){
            print(e);
        }
        
    }

    // Get city name
    Future<String> getCityName(double lat, double lon) async{
        List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat, lon); // find city from geolocator with lat and lon from current location (await from geolocator)
        print('City name is: ${placemark[0].locality}');
        return placemark[0].locality; // return city name
    }
}