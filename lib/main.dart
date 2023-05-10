import 'package:flutter/material.dart';
import 'package:ipchecker/provider_card.dart';

import 'providers/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Check',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(title: 'IP Checker'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Future<ProviderResult>> providerResults = [];

  @override
  void initState() {
    for (var provider in providers) {
      providerResults.add(provider.getData());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: providers.length,
        itemBuilder: (context, index) {
          return ProviderCard(
              providerResultFuture: providerResults[index],
              providerName: providers[index].name);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _reload();
        },
        child: const Icon(Icons.replay),
      ),
    );
  }

  void _reload() {
    var newProviderResults = <Future<ProviderResult>>[];
    for (var provider in providers) {
      newProviderResults.add(provider.getData());
    }
    setState(() {
      providerResults = newProviderResults;
    });
  }
}
