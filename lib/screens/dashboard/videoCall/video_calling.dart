import 'package:easy_patient/classes/webRTC/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCalling extends StatefulWidget {
  final String callerId, calleeId;
  final dynamic offer;
  const VideoCalling(
      {super.key, this.offer, required this.calleeId, required this.callerId});

  @override
  State<VideoCalling> createState() => _VideoCallingState();
}

class _VideoCallingState extends State<VideoCalling> {
  // socket instance
  final socket = SignallingService.instance.socket;

  // videoRenderer for localPeer
  final _localRTCVideoRenderer = RTCVideoRenderer();

  // videoRenderer for remotePeer
  final _remoteRTCVideoRenderer = RTCVideoRenderer();

  // mediaStream for localPeer
  MediaStream? _localStream;

  // RTC peer connection
  RTCPeerConnection? _rtcPeerConnection;

  // list of rtcCandidates to be sent over signalling
  List<RTCIceCandidate> rtcIceCadidates = [];
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;
  bool _isCallEnd = false;

  @override
  void initState() {
    super.initState();
    initRenderers();
    _connect();
    _endCall();
  }

  Future<void> initRenderers() async {
    await _localRTCVideoRenderer.initialize();
    await _remoteRTCVideoRenderer.initialize();
  }

  _connect() async {
    // create peer connection
    _rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });

    // listen for remotePeer mediaTrack event
    _rtcPeerConnection!.onTrack = (event) {
      _remoteRTCVideoRenderer.srcObject = event.streams[0];
      setState(() {});
    };

    // get localStream
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });

    // add mediaTrack to peerConnection
    _localStream!.getTracks().forEach((track) {
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });

    // set source for local video renderer
    _localRTCVideoRenderer.srcObject = _localStream;
    setState(() {});

    // for Incoming call
    if (widget.offer != null) {
      // listen for Remote IceCandidate
      socket!.on("IceCandidate", (data) {
        String candidate = data["iceCandidate"]["candidate"];
        String sdpMid = data["iceCandidate"]["id"];
        int sdpMLineIndex = data["iceCandidate"]["label"];

        // add iceCandidate
        _rtcPeerConnection!.addCandidate(RTCIceCandidate(
          candidate,
          sdpMid,
          sdpMLineIndex,
        ));
      });

      // set SDP offer as remoteDescription for peerConnection
      await _rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(widget.offer["sdp"], widget.offer["type"]),
      );

      // create SDP answer
      RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();

      // set SDP answer as localDescription for peerConnection
      _rtcPeerConnection!.setLocalDescription(answer);

      // send SDP answer to remote peer over signalling
      socket!.emit("answerCall", {
        "callerId": widget.callerId,
        "sdpAnswer": answer.toMap(),
      });
    }
    // for Outgoing Call
    else {
      // listen for local iceCandidate and add it to the list of IceCandidate
      _rtcPeerConnection!.onIceCandidate =
          (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);

      // when call is accepted by remote peer
      socket!.on("callAnswered", (data) async {
        // set SDP answer as remoteDescription for peerConnection
        await _rtcPeerConnection!.setRemoteDescription(
          RTCSessionDescription(
            data["sdpAnswer"]["sdp"],
            data["sdpAnswer"]["type"],
          ),
        );

        // send iceCandidate generated to remote peer over signalling
        for (RTCIceCandidate candidate in rtcIceCadidates) {
          socket!.emit("IceCandidate", {
            "calleeId": widget.calleeId,
            "iceCandidate": {
              "id": candidate.sdpMid,
              "label": candidate.sdpMLineIndex,
              "candidate": candidate.candidate
            }
          });
        }
      });

      // create SDP Offer
      RTCSessionDescription offer = await _rtcPeerConnection!.createOffer();

      // set SDP offer as localDescription for peerConnection
      await _rtcPeerConnection!.setLocalDescription(offer);

      // make a call to remote peer over signalling
      socket!.emit('makeCall', {
        "calleeId": widget.calleeId,
        "calleeName": "Nandu",
        "calleeType": "patient",
        "sdpOffer": offer.toMap(),
      });
    }
  }

  void _endCall() {
    socket!.on("callEnded", (data) {
      _localStream!.getTracks().forEach((track) => track.stop());
      socket!.emit('endCall');
      Navigator.pop(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _localRTCVideoRenderer.dispose();
    _remoteRTCVideoRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();
    _localStream?.getTracks().forEach((track) => track.stop());
  }

  _leaveCall() {
    _localStream!.getTracks().forEach((track) => track.stop());
    socket!.emit('endCall');
    Navigator.pop(context);
  }

  _toggleMic() {

    if (_localStream != null) {
      // change status

      isAudioOn = !isAudioOn;
      // enable or disable audio track
      _localStream?.getAudioTracks().forEach((track) {
        track.enabled = isAudioOn;
      });
      setState(() {});
    }


  }

  _toggleCamera() {
    // change status
    isVideoOn = !isVideoOn;

    // enable or disable video track
    _localStream!.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
    setState(() {});
  }

  _switchCamera() {
    // change status
    isFrontCameraSelected = !isFrontCameraSelected;

    // switch camera
    _localStream!.getVideoTracks().forEach((track) {
      // ignore: deprecated_member_use
      track.switchCamera();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          RTCVideoView(
            _remoteRTCVideoRenderer,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            // filterQuality: FilterQuality.high,
          ),
          Positioned(
            right: 20,
            bottom: 50,
            child: SizedBox(
              height: 150,
              width: 120,
              child: RTCVideoView(
                _localRTCVideoRenderer,
                mirror: true,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                // filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ]),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: _toggleMic,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAudioOn ? Colors.red : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isAudioOn ? Icons.mic_off : Icons.mic,
                    color: isAudioOn ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: _toggleCamera,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isVideoOn ? Colors.red : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isVideoOn ? Icons.videocam_off : Icons.videocam,
                    color: isVideoOn ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: _leaveCall,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: _switchCamera,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isFrontCameraSelected ? Colors.red : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFrontCameraSelected
                        ? Icons.flip_camera_ios
                        : Icons.switch_camera,
                    color: isFrontCameraSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       // _isVideoOff = !_isVideoOff;
              //     });
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.all(12),
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       shape: BoxShape.circle,
              //     ),
              //     child: const Icon(
              //       Icons.add_call,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

// getUserMedia() async {
//   final Map<String, dynamic> mediaConstraints = {
//     "audio": false,
//     "video": {
//       "facingMode": "user",
//     }
//   };
//   stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
//   localRenderer.srcObject = stream;
// }
//
// void _onPressed(List<String> errorInvitees, String code, String message) {
//   if (errorInvitees.isNotEmpty) {
//     String userIDs = "";
//     for (int index = 0; index < errorInvitees.length; index++) {
//       if (index >= 5) {
//         userIDs += '... ';
//         break;
//       }
//
//       var userID = errorInvitees.elementAt(index);
//       userIDs += '$userID ';
//     }
//     if (userIDs.isNotEmpty) {
//       userIDs = userIDs.substring(0, userIDs.length - 1);
//     }
//
//     var message = 'User does\'t exist or is offline: $userIDs';
//     if (code.isNotEmpty) {
//       message += ', code: $code, message:$message';
//     }
//     ShowMassage().showMassage(message, Colors.red.shade400);
//   } else if (code.isNotEmpty) {
//     ShowMassage().showMassage(message, Colors.red.shade400);
//   }
// }
