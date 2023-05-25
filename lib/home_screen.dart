import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'models/PostModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<PostModel> postlist = [];
  Future<List<PostModel>> getpostApi() async {
    final reponse =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
   var data=jsonDecode(reponse.body.toString());
    if (reponse.statusCode == 200) {

      for (Map i in data) {
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('rest api'),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [

          Expanded(
            child: FutureBuilder(
                future: getpostApi(),
                builder: (context, Snapshot) {
                  if (!Snapshot.hasData) {
                    return Text('loading');   //CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                          itemCount: postlist.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                Text(
                                  'Title',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(postlist[index].title.toString()),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(postlist[index].body.toString())

                              ]),
                            );
                          });
                  }
                }),
          )
        ]));
  }
}
