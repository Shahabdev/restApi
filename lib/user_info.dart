import 'dart:convert';
import 'models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class model_user extends StatefulWidget {
  const model_user({Key? key}) : super(key: key);

  @override
  State<model_user> createState() => _model_userState();
}

class _model_userState extends State<model_user> {
  List<UserModel> userlist = [];
  Future<List<UserModel>> getuserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('user info api')),
        body:
            Column(children: [
              Expanded(
                child: FutureBuilder(
                    future:getuserApi(),
                  builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Text(' loading');
                      }
                      else{
                        return ListView.builder(
                            itemCount:userlist.length,
                            itemBuilder: (context,index){
                              return Card(
                                child:Column(
                                  //crossAxisAlignment: CrossAxisAlignment.,
                                  children: [
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //
                                  //   children: [
                                  //     Text('name'),
                                  //     Text(snapshot.data![index].name.toString()),
                                  //
                                  //   ],
                                  // ),
                                  //   Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //
                                  //     children: [
                                  //
                                  //       Text('id'),
                                  //       Text(snapshot.data![index].id.toString()),
                                  //     ],
                                  //   ),
                                    ReusableRow(title:'Name',value: snapshot.data![index].name.toString(),),
                                    ReusableRow(title:'Email',value: snapshot.data![index].email.toString(),),

                                    ReusableRow(title:'Id',value: snapshot.data![index].id.toString(),)


                                  ],
                                ) ,
                              );

                            });
                      }


            }),
              )]));
  }
}
 class ReusableRow extends StatelessWidget {
    String title,value;
    ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(title),
           Text(value)
         ],
       ),
     );
   }
 }
