import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Four_example extends StatefulWidget {
  const Four_example({Key? key}) : super(key: key);

  @override
  State<Four_example> createState() => _Four_exampleState();
}

class _Four_exampleState extends State<Four_example> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('get api with creating own model'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('loading ');
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'name',
                                      value: data[index]['name'].toString()),
                                  ReusableRow(
                                      title: 'user name',
                                      value:
                                          data[index]['username'].toString()),

                                  // ReusableRow(
                                  //     title: 'user name',
                                  //     value: data[index]['address'].toString()),
                                  ReusableRow(
                                      title: 'street',
                                      value: data[index]['address']['street']
                                          .toString()),
                                  ReusableRow(title: 'user name', value:data[index]['address']['geo'].toString()),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
