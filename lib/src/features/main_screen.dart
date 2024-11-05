import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  Future<String>? _getCityFromZip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: const TextStyle(color: Colors.amber),
                controller: _controller,
                decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.amber),
                    border: OutlineInputBorder(),
                    labelText: "Postleitzahl"),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _getCityFromZip = getCityFromZip(_controller.text);
                  });
                },
                child: const Text(
                  "Suche",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              const SizedBox(height: 32),
              FutureBuilder(
                  future: _getCityFromZip,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text(
                        "Fehler beim Laden der Stadt",
                        style: TextStyle(color: Colors.amber),
                      );
                    } else if (snapshot.hasData) {
                      return Text(
                        "Ergebnis: ${snapshot.data}",
                        style: const TextStyle(color: Colors.amber),
                      );
                    } else {
                      return const Text(
                        "Noch keine PLZ gesucht",
                        style: TextStyle(color: Colors.amber),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  //Eine .dispose()Methode ist ein Rückruf, den wir verwenden,
  // wenn wir die Verwendung von etwas beenden möchten.
  // Quelle stackoverflow.com
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "44866":
        return "Bochum Wattenscheid";
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
