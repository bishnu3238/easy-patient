import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../notification_manager/call_manager.dart';
import '../util/customSnackBar.dart';

class SignallingService {
  io.Socket? socket;
  dynamic _incomingSDPOffer;

  set incomingSDPOffer(dynamic offer) {
    _incomingSDPOffer = offer;
  }

  dynamic get incomingSDPOffers => _incomingSDPOffer;

  SignallingService._();
  static final instance = SignallingService._();

  Future<void> init(
      {required String socketUrl,
      required String patientID,
      required context}) async {
    final completer = Completer<void>();

    // init Socket
    socket = io.io(
      socketUrl,
      io.OptionBuilder()
          .setQuery({"callerId": patientID})
          .disableAutoConnect()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .build(),
    );

    // listen onConnect event
    socket!.onConnect((data) {
      log("Socket connected !!");
      CustomSnackBar.showSnackIsOnline(true);

      completer.complete();
    });

    // listen onConnectError event
    socket!.onConnectError((data) {
      log("Connect Error $data");
      CustomSnackBar.showSnackIsOnline(false);
      completer.completeError(data);
    });

    // listen onClose event
    socket!.onclose((reason) {
      log("Reason : $reason");
      completer.completeError(reason);
    });

    // connect socket
    socket!.connect();

    return completer.future;
  }

  Future<dynamic> listenIncomingCall(context) async {
    dynamic incomingSDPOffer;
    // listen for incoming video call
    socket!.on("newCall", (data) async {
      log("data: $data");
      if (data != null) {
        incomingSDPOffer = data;
        var incomingData = await CallManager()
            .showIncomingCall(data["callerId"], data, context);
        if (incomingData != null) {
          CustomSnackBar.initialize(context);
          CustomSnackBar.showSnackBar(
              "Call from Mr. ${data['callerId']}", null, context);
          return incomingSDPOffer;
        }
      } else {
        log("nothing to show !! ...");
      }
    });
  }
}

// class SignallingService {
//   io.Socket? socket;
//
//   SignallingService._();
//   static final instance = SignallingService._();
//
//   init({required String socketUrl, required String doctorID}) {
//     // {
//     //   "transports": ['websocket'],
//     // "query": {"callerId": doctorID}
//     // }
//     ///
//     // init Socket
//     socket = io.io(
//       socketUrl,
//       io.OptionBuilder()
//           .setQuery({"callerId": doctorID})
//           .disableAutoConnect()
//           .setTransports(['websocket']) // for Flutter or Dart VM
//           .build(),
//     );
//
//     // listen onConnect event
//     socket!.onConnect((data) {
//       log("Socket connected !!");
//     });
//
//     // listen onConnectError event
//     socket!.onConnectError((data) {
//       log("Connect Error $data");
//     });
//
//     // listen onClose event
//     socket!.onclose((reason) {
//       log("Reason : $reason");
//     });
//
//     // connect socket
//     socket!.connect();
//   }
// }

// class SignallingService {
//   Socket? socket;
//   dynamic incoming;
//
//   get incomingSDPOffer => incoming;
//
//   set incomingSDPOffer(dynamic offer) {
//     incoming = offer;
//   }
//
//   SignallingService._();
//   static final instance = SignallingService._();
//
//   init({required String socketUrl, required String patientID}) {
//     // init Socket
//
//     // socket = io(socketUrl, {
//     //   "transports": ['websocket'],
//     //   "query": {"callerId": patientID}
//     // });
//
//     socket = io(
//       socketUrl,
//       OptionBuilder()
//           .setQuery({"callerId": patientID})
//           .disableAutoConnect()
//           .setTransports(['websocket']) // for Flutter or Dart VM
//           .build(),
//     );
//
//
//
//
//     // listen onConnect event
//     socket!.onConnect((data) {
//       log("Socket connected !! $data");
//     });
//
//     // listen onConnectError event
//     socket!.onConnectError((data) {
//       log("Connect Error $data");
//     });
//
//     // listen onClose event
//     socket!.onclose((reason) {
//       log("Reason : $reason");
//     });
//
//     // connect socket
//     socket!.connect();
//   }
// }
