import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseNetworkInfo {
  Future<bool> get isConnected;
}

class NetWorkInfo implements BaseNetworkInfo{
  final InternetConnectionChecker connectionChecker;

  NetWorkInfo({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

}