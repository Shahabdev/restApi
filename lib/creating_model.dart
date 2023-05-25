import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SecondExample extends StatefulWidget {
  const SecondExample({Key? key}) : super(key: key);

  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {
  List<Photos> listphotos=[];
  Future<List<Photos>> getPhotos()async
  {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
   var data=jsonDecode(response.body.toString());
   if(response.statusCode==200)
     {
       for(Map i in data)
         {
           Photos photos=Photos(title: i['title'], url:i['url'],id:i['id']);
           listphotos.add(photos);
         }
         return listphotos;
     }
    else
      {
        return listphotos;
      }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title:Text('crreating model by explicitly')
      ),
      body:Column(
        children:[
                Expanded(
                  child: FutureBuilder(
                      future: getPhotos(),
                      builder: (context,AsyncSnapshot<List<Photos>>snapshot)
                      {
                        return ListView.builder(
                            itemCount:listphotos.length,
                            itemBuilder: (context,index)
                        {
                          return ListTile(
                            leading:CircleAvatar(
                              backgroundImage:NetworkImage(snapshot.data![index].url.toString())
                            ) ,
                            title:Text(snapshot.data![index].title.toString()),
                            subtitle:Text(snapshot.data![index].id.toString())
                          );
                        });
                      }),
                )
        ]
      )
    );
  }
}
class Photos
{
  String title,url;
  int id;
  Photos({required this.title,required this.url,required this.id});
}
