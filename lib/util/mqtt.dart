// https://pub.dev/packages/mqtt_client/versions/5.5.1/example

import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';

class TMqtt {
  MqttClient client;

  Future<bool> Init(String aHost) async {
    client = MqttClient('test.mosquitto.org', '');
    //client = MqttClient(aHost, 'q1');
    //client = MqttClient.withPort('mqtt://' + aHost, '#', 1883);
    client.keepAlivePeriod = 20;
    client.logging(on: true);
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('clientIdentifier-xxx1')
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMess;

    try {
      await client.connect();
      return (client.connectionStatus.state == MqttConnectionState.connected);
    } catch (e) {
      print('Error: TMqtt::Init $e');
      Disconnect();
      return false;
    }
  }

  Disconnect() {
    client?.disconnect();
    client = null;
  }

  void onConnected() {}

  void onDisconnected() {}

  void onSubscribed(String topic) {
    print(topic);
  }
}
