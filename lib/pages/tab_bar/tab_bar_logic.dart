import 'dart:io';

import 'package:flutter/material.dart';
import 'package:demoflutter/JWTools/jw_tools.dart';
import 'package:get/get.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class Tab_barLogic extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  final selIndex = 0.obs;

  List<AnimationController> tabControllers = [];
  WebSocketChannel? webSocketChannel;
  String? wsUrl;
  final hasNotify = false.obs;
  final hasMSg = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("onInit");
    // wsUrl = "ws://10.50.204.238:9502?token=${JWManager().token}";
    // connectSocket();
    tabController = TabController(length: 2, vsync: this);
    for (int i = 0; i < 2; i++) {
      tabControllers.add(
          AnimationController(vsync: this, duration: Duration(seconds: 1)));
    }
  }

  void connectSocket() async {
    var wsuri = Uri.parse(wsUrl!);

    webSocketChannel = WebSocketChannel.connect(wsuri);
    try {
      await webSocketChannel?.ready;
      webSocketChannel?.stream.listen((message) {
        print("websocket->Connect success❤, received message:$message");
        // webSocketChannel?.sink.add("received");
      }, onDone: onClose, onError: onWsError, cancelOnError: false);
    } on SocketException catch (e) {
      // Handle the exception.
      print("on SocketException:$e");
    } on WebSocketChannelException catch (e) {
      // Handle the exception.
      print("on WebSocketChannelException:$e");
    }
  }

  void onWsClosed() {
    print("websocket 断开");
    Future.delayed(const Duration(seconds: 1), () {
      print("websocket->重连......");
      connectSocket();
    });
  }

  void onWsError(err, StackTrace stackTrace) {
    print("websocket->出错:$err");
    print(stackTrace);
  }

  changeBottomIndex(int index) {
    print("tabbar index:$index");
    if (index == 2) {
      if (!JWManager().checkLogin()) {
        return;
      }
    }
    selIndex.value = index;
    tabController.animateTo(selIndex.value);
    tabControllers[index]
      ..reset()
      ..forward();
  }

  void toBack() {}

  void toMsg() {}

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
