// https://pub.dev/packages/mqtt_client/versions/5.5.1/example

import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class TMqtt {
  mqtt.MqttClient client;

  Future<bool> Init(String aHost) async {
    client = mqtt.MqttClient(aHost, '');
    try {
      await client.connect();
      return (client.connectionStatus.state == mqtt.MqttConnectionState.connected);
    } catch (e) {
      Disconnect();
      return false;
    }
  }

  Disconnect() {
    client?.disconnect();
    client = null;
  }

  bool Test() {
    return true;
  }

}
