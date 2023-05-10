import 'package:flutter/material.dart';

import 'providers/provider.dart';

class ProviderCard extends StatelessWidget {
  final Future<ProviderResult> providerResultFuture;
  final String providerName;

  const ProviderCard({
    Key? key,
    required this.providerResultFuture,
    required this.providerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: FutureBuilder(
      future: providerResultFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            ProviderResult result = snapshot.data as ProviderResult;
            List<Widget> children = [];
            children.add(Text("ip: ${result.ip}"));
            if (result.location != null) {
              children.add(Text("location: ${result.location}"));
            }
            if (result.isp != null) {
              children.add(Text("ISP: ${result.isp}"));
            }

            return ListTile(
              title: Text(providerName),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children),
            );
          } else if (snapshot.hasError) {
            return ListTile(
              title: Text(providerName),
              subtitle: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListTile(
                title: Text(providerName), subtitle: const Text('Logic error'));
          }
        } else {
          return const Center(
              child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ));
        }
      },
    ));
  }
}
