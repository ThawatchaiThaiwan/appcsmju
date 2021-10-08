import 'dart:convert';

import 'package:appcsmju/api/apinew.dart';
// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = (Uri.parse("https://wwwdev.csmju.com/api/news"));

  var _dataFromAPI = [];

  Future<String> _getnews() async {
    //var url = Uri.parse("https://wwwdev.csmju.com/api/news");
    try {
      final response = await http.get(url);
      final jsonData = jsonDecode(response.body);
      print(response.body);

      setState(() {
        _dataFromAPI = jsonData;
      });
    } catch (err) {}
    //return apinewFromJson(response.body)[0].newsDetail;

    //_dataFromAPI = apinewFromJson(news.body) as Apinew;
    //print(jsonData);

    return "ok";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getnews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[75],
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.people),
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_alert_sharp),
              color: Colors.black,
            ),
            // ignore: dead_code
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: _getnews(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.error != null) {
                return Text("error");
                //child: Text("newsId:${post["newsId"]} \n News_Detail : ${post["News_Detail"]}"),
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: _dataFromAPI.length,
                    itemBuilder: (context, i) {
                      final post = _dataFromAPI[i];
                      return SizedBox(
                 

                        width: 206,
                        height: 222,
                        child: Material(
                          child: Text(":${post["newsId"]} \n  : ${post["News_Detail"]}"),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color: Color(0xffd1cccc),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));

    //child: Text(_dataFromAPI?.newsDetail ?? "loadind..."),
  }
}
