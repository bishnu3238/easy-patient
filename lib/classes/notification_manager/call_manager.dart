import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import '../../screens/dashboard/videoCall/video_calling.dart';

class CallManager {
  Future<dynamic> showIncomingCall(
      String uuid, dynamic data, BuildContext context) async {
    dynamic currentCall;

    var params = CallKitParams(
      id: data["callerId"],
      nameCaller: 'CAllER NAME',
      appName: 'EazyDoctor',
      avatar: 'assets/images/doctor.png',
      handle: data["callerId"],
      type: 1,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      textMissedCall: 'Missed call',
      textCallback: 'Call back',
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: false,
        isShowLogo: true,
        isShowCallback: true,
        isShowMissedCallNotification: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'assets/pill.png',
        actionColor: '#4CAF50',
        incomingCallNotificationChannelName: "Incoming Call",
        isCustomSmallExNotification: true,
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
      switch (event!.event) {
        case Event.ACTION_CALL_INCOMING:
          // TODO: received an incoming call
          break;
        case Event.ACTION_CALL_START:
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
          break;
        case Event.ACTION_CALL_ACCEPT:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => VideoCalling(
                        callerId:
                            data != null ? data["callerId"]! : "9231520717",
                        calleeId: data != null ? "9231520717" : "9231665466",
                        offer: data != null ? data["sdpOffer"] : null,
                      )));

          currentCall = await getCurrentCall();
          // if (currentCall != null) {
          //   return data;
          // }        // TODO: accepted an incoming call
          // TODO: show screen calling in Flutter
          break;
        case Event.ACTION_CALL_DECLINE:
          FlutterCallkitIncoming.endCall(data["callerId"]);
          // TODO: declined an incoming call
          break;
        case Event.ACTION_CALL_ENDED:
          FlutterCallkitIncoming.endCall(data["callerId"]);

          // TODO: ended an incoming/outgoing call
          break;
        case Event.ACTION_CALL_TIMEOUT:
          FlutterCallkitIncoming.endCall(data["callerId"]);

          // TODO: missed an incoming call
          break;
        case Event.ACTION_CALL_CALLBACK:
          // TODO: only Android - click action `Call back` from missed call notification
          break;
        case Event.ACTION_CALL_TOGGLE_HOLD:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_MUTE:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_DMTF:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_GROUP:
          // TODO: only iOS
          break;
        case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
          // TODO: only iOS
          break;
        case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
          // TODO: only iOS
          break;
      }
    });

    if (currentCall != null) {
      return data;
    }
  }

  getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls.isNotEmpty) {
      log('DATA: $calls');

      return calls[0];
    } else {
      return null;
    }
  }
}
