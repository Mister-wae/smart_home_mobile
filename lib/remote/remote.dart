// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_mobile/remote/remote_provider.dart';

class RemoteAccess extends StatefulWidget {
  const RemoteAccess({super.key});

  @override
  State<RemoteAccess> createState() => _RemoteAccessState();
}

class _RemoteAccessState extends State<RemoteAccess> {
  @override
  void initState() {
    super.initState();
    Provider.of<RemoteProvider>(context, listen: false).getUserDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
        title: const Center(
          child: Text(
            "Remote Access",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<RemoteProvider>(
          builder: (BuildContext context, RemoteProvider value,
                  Widget? child) =>
              value.userDevices.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 120,
                      ),
                      itemBuilder: (context, index) {
                        String onCommand = "A";
                        String offCommand = "B";
                        switch (index) {
                          case 1:
                            onCommand = "A";
                            offCommand = "B";
                          case 2:
                            onCommand = "C";
                            offCommand = "D";
                          case 3:
                            onCommand = "E";
                            offCommand = "F";
                          case 4:
                            onCommand = "G";
                            offCommand = "H";
                          case 5:
                            onCommand = "I";
                            offCommand = "J";
                          case 6:
                            onCommand = "K";
                            offCommand = "L";
                          case 7:
                            onCommand = "M";
                            offCommand = "N";
                          case 8:
                            onCommand = "O";
                            offCommand = "P";
                            break;
                          default:
                        }

                        return LightSwitch(
                          onCommand: onCommand,
                          offCommand: offCommand,
                        );
                      },
                      itemCount: 8,
                    )
                  : Center(
                      child: TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(
                            Size(MediaQuery.sizeOf(context).width * 0.6, 60),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.black),
                        ),
                        child: const Text(
                          "Get Devices",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          bool response = await Provider.of<RemoteProvider>(
                                  context,
                                  listen: false)
                              .getAvailableDevices();
                          if (response == true) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => const AvailableDevices(),
                            );
                          } else {}
                        },
                      ),
                    ),
        ),
      ),
    );
  }
}

class LightSwitch extends StatefulWidget {
  const LightSwitch(
      {super.key, required this.onCommand, required this.offCommand});
  final String onCommand;
  final String offCommand;

  @override
  State<LightSwitch> createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitch> {
  List toggles = ["assets/on_toggle.png", "assets/off_toggle.png"];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<RemoteProvider>(
      builder: (BuildContext context, RemoteProvider value, Widget? child) =>
          ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Container(
          height: 120,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          color: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    "Light",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (index == 0) {
                        bool response = await Provider.of<RemoteProvider>(
                                context,
                                listen: false)
                            .commandDevice(value.userDevices.first["user"],
                                widget.onCommand);
                        if (response == true) {
                          setState(() {
                            index = 1;
                          });
                        } else {}
                      } else {
                        bool response = await Provider.of<RemoteProvider>(
                                context,
                                listen: false)
                            .commandDevice(value.userDevices.first["user"],
                                widget.offCommand);
                        if (response == true) {
                          setState(() {
                            index = 0;
                          });
                        } else {}
                      }
                    },
                    child: Image.asset(
                      toggles[index],
                      height: 45,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.light_mode_sharp,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AvailableDevices extends StatefulWidget {
  const AvailableDevices({super.key});

  @override
  State<AvailableDevices> createState() => _AvailableDevicesState();
}

class _AvailableDevicesState extends State<AvailableDevices> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RemoteProvider>(
      builder: (BuildContext context, RemoteProvider value, Widget? child) =>
          Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.devices_other,
                color: Colors.black,
                size: 30,
              ),
              title: Text(value.availableDevices[index]
                  .toString()
                  .replaceRange(0, 9, "")),
              trailing: IconButton(
                onPressed: () async {
                  bool response =
                      await Provider.of<RemoteProvider>(context, listen: false)
                          .addDevices(
                    value.availableDevices[index]
                        .toString()
                        .replaceRange(0, 9, ""),
                    value.availableDevices[index].toString(),
                  );
                  if (response == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added Successfully"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Failed"),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.add_circle_outlined,
                  color: Colors.black,
                ),
              ),
            );
          },
          itemCount: value.availableDevices.length,
        ),
      ),
    );
  }
}
