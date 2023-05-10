import 'package:ipchecker/providers/provider.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';

class NiconicoProvider implements Provider {
  @override
  final name = 'Niconico';

  @override
  Future<ProviderResult> getData() async {
    Response response = await get(
      Uri.parse('https://www.nicovideo.jp/diagnostics/'),
    );
    var document = parse(response.body);
    String ip = document.getElementById("DiagnosticsPage-ip")!.text;
    String? country = document.getElementById("DiagnosticsPage-country")?.text;

    return ProviderResult(ip, country, null);
  }
}
