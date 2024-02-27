# flutter_libserialport_example_mvp

A new Flutter project demonstrating how to use
the [flutter_libserialport](https://pub.dev/packages/flutter_libserialport).

## MVP includes

- get list of available devices
- read data (listen to port reader stream)
- write data

## Getting Started

To get started just pull this project and try it out for yourself. Obviously you might need to
update the message send to the device as the expected message format differs from device to device.

## libserialport package links
- [The original c-library created by the sigrok group](https://github.com/sigrokproject/libserialport/tree/master)
- [The dart wrapper library around this c-library](https://pub.dev/packages/libserialport)
- [The flutter wrapper library around this dart library](https://pub.dev/packages/flutter_libserialport)

### MacOS
**Please make sure you give the application permissions to use the serial port on MacOS**
`https://github.com/jpnurmi/flutter_libserialport/issues/30`

Output for the main.dart on MacOS
````
flutter: /dev/cu.usbserial-AE01I87G opened!
flutter: message send [48, 48, 49, 48, 48, 48, 49, 48, 48, 50, 61, 63, 48, 57, 54, 13]
flutter: message received [48, 48, 49, 49, 48, 48, 49, 48, 48, 54, 48, 48, 48, 48, 48, 48, 48, 48, 57, 13]
flutter: 0011001006000000009
```