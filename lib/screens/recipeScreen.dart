import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

import '../utils/model.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<Model> list = <Model>[];
  String? text;
  final url =
      'https://api.edamam.com/search?q=chicken&app_id=00d1806b&app_key=7e0f86b9a1d5acf0457b9917aecbb0e0&from=0&to=100&calories=591-722&health=alcohol-free';

  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
        url: e['recipe']['url'],
        image: e['recipe']['image'],
        source: e['recipe']['source'],
        label: e['recipe']['label'],
      );
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 173, 179),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Recipe"),
        backgroundColor: const Color.fromARGB(255, 121, 12, 116),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (v) {
                  text = v;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                    search: text,
                                  )));
                    },
                    icon: const Icon(Icons.search),
                  ),
                  hintText: "Search For A Recipe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.green.withOpacity(0.04),
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                    url: x.url,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(x.image.toString()),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: 40,
                            color: const Color.fromARGB(255, 121, 12, 116)
                                .withOpacity(0.5),
                            child: Center(child: Text(x.label.toString())),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: 40,
                            color: const Color.fromARGB(255, 121, 12, 116)
                                .withOpacity(0.5),
                            child: Center(
                                child: Text("Source : " + x.source.toString())),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebPage extends StatelessWidget {
  final url;
  const WebPage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String changeUrl = url;
    changeUrl.contains('https')
        ? changeUrl = changeUrl
        : changeUrl = changeUrl.replaceAll('http', 'https');
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: changeUrl,
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  final String? search;
  const SearchPage({Key? key, this.search}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Model> list = <Model>[];
  String? text;

  getApiData(search) async {
    final url =
        'https://api.edamam.com/search?q=$search&app_id=00d1806b&app_key=7e0f86b9a1d5acf0457b9917aecbb0e0&from=0&to=100&calories=591-722&health=alcohol-free';
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
        url: e['recipe']['url'],
        image: e['recipe']['image'],
        source: e['recipe']['source'],
        label: e['recipe']['label'],
      );
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getApiData(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 173, 179),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Recipe"),
        backgroundColor: const Color.fromARGB(255, 121, 12, 116),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                    url: x.url,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(x.image.toString()),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: 40,
                            color: const Color.fromARGB(255, 121, 12, 116)
                                .withOpacity(0.5),
                            child: Center(child: Text(x.label.toString())),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            height: 40,
                            color: const Color.fromARGB(255, 121, 12, 116)
                                .withOpacity(0.5),
                            child: Center(
                                child: Text("Source : " + x.source.toString())),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
