import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

Uint8List createMessage(String request) {
  return Uint8List.fromList(request.codeUnits);
}

void onclick() {
  /// Initialize SerialPort and SerialPortReader variables for later
  late SerialPort port;
  late SerialPortReader reader;

  /// The config for the serial port created
  /// The variables are dependent on your specific device
  /// Usually you will have to at least update the baudRate
  final SerialPortConfig config = SerialPortConfig();
  config.baudRate = 9600;
  config.parity = 0;
  config.bits = 8;
  config.cts = 0;
  config.rts = 1;
  config.dtr = 1;
  config.stopBits = 1;
  config.xonXoff = 3;

  /// The request string send over the serial port to the device
  /// Please update this depending on your device
  final Uint8List message = createMessage("0010001002=?096\r");

  /// Get a list of all available Ports
  /// Select the one for your device.
  /// Here we will just take the first one, that has "usbserial" in its name, to keep things simple.
  List<String>? availablePorts = SerialPort.availablePorts;
  final serialPath = availablePorts.firstWhere(
    (element) => element.contains('usbserial'),
    orElse: () => availablePorts.first,
  );

  /// Now that we have the serialPath i.e. the port we want we can initialize the SerialPort
  port = SerialPort(serialPath);

  /// Next we check if the port is already open, and if that is the case close it so that we can continue
  if (port.isOpen) {
    port.close();
  }

  /// Now we can continue opening the port
  try {
    /// Here we open the SerialPort for both reading and writing
    /// The function will return true if it opened successfully and we can continue.
    if (port.open(mode: SerialPortMode.readWrite)) {
      /// Now that the SerialPort is opened we can create the SerialPortReader that we will use to listen to messages
      /// send by the device
      reader = SerialPortReader(port);

      /// Only now can we update the config of our SerialPort
      /// This is important since it would be overwritten if specified before opening the port
      port.config = config;

      /// Next we can check if the port is truly opened. This is not necessary per se but good to know.
      if (port.isOpen) {
        debugPrint('${port.name} opened!');
      }

      /// Now we can write a message
      /// The write method returns the number of items send, this should be equal to the length of our message
      if (port.write(message) == message.length) {
        print("message send $message");
      }

      /// Here we listen to the stream of the SerialPortReader
      /// All messages send from the device over the port to you will be received here
      reader.stream.listen(
          (List<int> data) {
            print("message received $data");

            /// Now we can convert the charCodes received back to a String
            String buffer = String.fromCharCodes(data);
            print(buffer);
          },
          onError: (error) => print(error),
          onDone: () {
            print("done with listening");
          });
    }
  } on SerialPortError catch (err, _) {
    /// In case the SerialPort threw any errors during execution we can handle them here
    print(SerialPort.lastError);

    /// To avoid blocking the port indefinitely even after the application breaks or an error is thrown
    /// we close the port.
    port.close();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Center(
            child: TextButton(
              onPressed: () {
                onclick();
              },
              child: const Text('Click me!'),
            ),
          ),
        ),
      ),
    );
  }
}
