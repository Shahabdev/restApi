import 'dart:convert';

import'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:rest_api10/models/ProductModel.dart';
class Product_screen extends StatefulWidget {
  const Product_screen({Key? key}) : super(key: key);

  @override
  State<Product_screen> createState() => _Product_screenState();
}

class _Product_screenState extends State<Product_screen> {
  Future<ProductModel> getApi()async{
    final reponse=await http.get(Uri.parse('https://webhook.site/7f3c6629-5935-4044-a559-473f2ab100f9'));
    var data=jsonDecode(reponse.body.toString());
    if(reponse.statusCode==200)
      {
        return ProductModel.fromJson(data);
      }
    else
      {
        return ProductModel.fromJson(data);

      }
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('product'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getApi(),
                builder:(context,snapshot)
            {
              if(snapshot.hasData)
                {
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context,index)
                  {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height:70,
                          child: ListTile(

                            title: Text(snapshot.data!.data![index].shop!.name.toString()),
                            subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                            trailing:Icon(Icons.add_shopping_cart) ,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*.3,
                          width: MediaQuery.of(context).size.width*1,

                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.data![index].images!.length,
                              itemBuilder: (context,position){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 25,left: 5,),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*.25,
                                    width: MediaQuery.of(context).size.width*.5,
                                    decoration:BoxDecoration(
                                      image:DecorationImage(
                                        fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data!.data![index].images![position].url.toString(),
                                          )
                                      ),
                                    )

                                  ),
                                );


                          }),
                        ),

                      ],
                    );
                  }
                  );


                }
              else
                {
                  return Text('loading');
                }
            }),
          )
        ],
      ),
    );
  }
}
