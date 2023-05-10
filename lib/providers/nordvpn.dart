import 'package:ipchecker/providers/provider.dart';
import 'package:http/http.dart';
import "dart:convert";

class NordvpnProvider implements Provider {
  @override
  final name = 'NordVPN';

  @override
  Future<ProviderResult> getData() async {
    Response response = await get(
      Uri.parse(
          'https://nordvpn.com/wp-admin/admin-ajax.php?action=get_user_info_data'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    var jsonData = jsonDecode(response.body);

    return ProviderResult(
      jsonData['ip'],
      jsonData['country'],
      jsonData['isp'],
    );
  }
}
