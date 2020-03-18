import 'package:socket_io_client/socket_io_client.dart' as IO;

const String APP_ID = '8e68be061686407cbf1d99f55b940d78';
const String SocketUrl = 'http://192.168.1.12:3000';

IO.Socket socket = IO.io('${SocketUrl}', <String, dynamic>{
  'transports': ['websocket'],
  // 'autoConnect': false,
  // 'extraHeaders': {'foo': 'bar'} // optional
});
// socket.connect()

const List<String> UserTypes = [
  '主席',
  '正方一辩',
  '正方二辩',
  '正方三辩',
  '正方四辩',
  '反方一辩',
  '反方二辩',
  '反方三辩',
  '反方四辩',
];
