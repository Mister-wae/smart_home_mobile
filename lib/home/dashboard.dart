import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_mobile/auth/auth_provider.dart';
import 'package:smart_home_mobile/functions.dart';
import 'package:smart_home_mobile/remote/remote_provider.dart';

class HomeDashBoard extends StatefulWidget {
  const HomeDashBoard({super.key});

  @override
  State<HomeDashBoard> createState() => _HomeDashBoardState();
}

class _HomeDashBoardState extends State<HomeDashBoard> {
  Map weatherData = {};

  @override
  Widget build(BuildContext context) {
    Provider.of<RemoteProvider>(context, listen: false).getUserDetails();
    Provider.of<AuthProvider>(context, listen: false).getWeatherData();

    return Consumer<RemoteProvider>(
      builder: (BuildContext context, RemoteProvider value, Widget? child) =>
          Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Welcome ${(value.userName ?? "User")}!",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${DateTime.now().weekday == 1 ? "Monday" : DateTime.now().weekday == 2 ? "Tuesday" : DateTime.now().weekday == 3 ? "Wednesday" : DateTime.now().weekday == 4 ? "Thursday" : DateTime.now().weekday == 5 ? "Friday" : DateTime.now().weekday == 6 ? "Saturday" : "Sunday"}, ${DateTime.now().day.toString()}/${DateTime.now().month}/${DateTime.now().year}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await Functions.getUserDevices();
                    },
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Consumer<AuthProvider>(
                  builder: (BuildContext context, AuthProvider value,
                          Widget? child) =>
                      ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: const Color.fromRGBO(40, 40, 41, 1),
                      height: 160,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.cloudy_snowing,
                              color: Colors.white,
                              size: 40,
                            ),
                            title: Text(
                              value.weather,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: const Text(
                              "Lagos, Nigeria",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${value.wind} Kmh",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text(
                                      "Wind",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${value.humidity} %",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text(
                                      "Humidity",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${value.pressure} hpa",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text(
                                      "Pressure",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: 120,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            9,
                          ),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: const SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Text(
                              "Consumed\nPower",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "0 Kwh",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: 120,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            9,
                          ),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            const Text(
                              "Connected\nDevices",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              Provider.of<RemoteProvider>(context)
                                      .userDevices
                                      .isNotEmpty
                                  ? "8"
                                  : "0",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      height: 120,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            9,
                          ),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/temp.svg",
                              height: 50,
                            ),
                            Text(
                              "${Provider.of<AuthProvider>(context).temp} °C",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
