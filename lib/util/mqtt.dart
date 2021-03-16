// https://github.com/shamblett/mqtt_client/blob/master/example/mqtt_server_client.dart

import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class TMqtt {
  MqttServerClient client;

  TMqtt(String aServer, int aPort, String aClientId) {
    client = init(aServer, aPort, aClientId);
  }

  MqttServerClient init(String aServer, int aPort, String aClientId) {
    MqttServerClient client = MqttServerClient(aServer, '');

    client.port = aPort;
    client.secure = false;
    client.keepAlivePeriod = 20;
    client.logging(on: true);
    client.onDisconnected = onDisconnect;
    client.onConnected = onConnect;
    client.onSubscribed = onSubscribe;

    final connMessage = MqttConnectMessage()
      //.authenticateAs('username', 'password')
      .withClientIdentifier(aClientId)
      .keepAliveFor(20) // Must agree with the keep alive set above or not set
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    return client;
  }

  Future<bool> connect() async {
    try {
      await client.connect();
      return (client.connectionStatus.state == MqttConnectionState.connected);
    } catch (e) {
      print('Error: TMqtt::connect $e');
      disconnect();
      return false;
    }
  }

  disconnect() {
    client?.disconnect();
    client = null;
  }

  void onConnect() {}

  void onDisconnect() {}

  void onSubscribe(String topic) {
    print(topic);
  }
}
