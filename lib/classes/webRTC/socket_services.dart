import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  Socket? socket;
  dynamic incoming;

  get incomingSDPOffer => incoming;

  set incomingSDPOffer(dynamic offer) {
    incoming = offer;
  }

  SignallingService._();
  static final instance = SignallingService._();

  init({required String socketUrl, required String patientID}) {
    // init Socket

    // socket = io(socketUrl, {
    //   "transports": ['websocket'],
    //   "query": {"callerId": patientID}
    // });

    socket = io(
      socketUrl,
      OptionBuilder()
          .setQuery({"callerId": patientID})
          .disableAutoConnect()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .build(),
    );




    // listen onConnect event
    socket!.onConnect((data) {
      log("Socket connected !! $data");
    });

    // listen onConnectError event
    socket!.onConnectError((data) {
      log("Connect Error $data");
    });

    // listen onClose event
    socket!.onclose((reason) {
      log("Reason : $reason");
    });

    // connect socket
    socket!.connect();
  }
}
