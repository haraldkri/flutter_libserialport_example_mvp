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

The project is build so that for each platform there will be a new branch but the develop branch
will have the changes of all other branches combined.

## libserialport package links
- [The original c-library created by the sigrok group](https://github.com/sigrokproject/libserialport/tree/master)
- [The dart wrapper library around this c-library](https://pub.dev/packages/libserialport)
- [The flutter wrapper library around this dart library](https://pub.dev/packages/flutter_libserialport)
