import 'package:flutter/material.dart';

import 'providers/provider.dart';

class ProviderCard extends StatefulWidget {
  final Provider provider;

  const ProviderCard({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  ProviderCardState createState() => ProviderCardState();
}

class ProviderCardState extends State<ProviderCard> {
  late Future<ProviderResult> _futureProviderResult;

  @override
  void initState() {
    super.initState();
    _futureProviderResult = widget.provider.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: FutureBuilder(
      future: _futureProviderResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ProviderResult result = snapshot.data as ProviderResult;
          return ListTile(
            title: Text(widget.provider.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result.ip),
                Text(result.location ?? 'Unknown location'),
                Text(result.isp ?? 'Unknown ISP'),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return ListTile(
            title: Text(widget.provider.name),
            subtitle: Text('Error: ${snapshot.error}'),
          );
        } else {
          return ListTile(
            title: Text(widget.provider.name),
            subtitle: const Text('Loading...'),
          );
        }
      },
    ));
  }
}
