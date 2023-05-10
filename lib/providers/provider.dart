import 'niconico.dart';
import 'nordvpn.dart';

class ProviderResult {
  final String ip;
  final String? location;
  final String? isp;

  ProviderResult(this.ip, this.location, this.isp);
}

abstract class Provider {
  final String name;

  Provider(this.name);

  Future<ProviderResult> getData();
}

final List<Provider> providers = [NordvpnProvider(), NiconicoProvider()];
