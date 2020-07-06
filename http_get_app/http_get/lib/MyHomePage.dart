import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'SizeConfig.dart';
import 'Space.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Space>> futureSpace;

  void initState() {
    super.initState();
    futureSpace = getData();
  }

  Future<List<Space>> getData() async {
    List<Space> list;
    String link = "https://sigmatenant.ml/mobile/tags";
    var res = await http.get(Uri.encodeFull(link));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["tags"] as List;
      list = rest.map<Space>((json) => Space.fromJson(json)).toList();
    }
    return list;
  }

  Widget spaceList(List<Space> space) {
    SizeConfig().init(context);
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal*5),
          child: Container(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal*3.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal*1),
                    child: Text(
                      space[index].displayName.toUpperCase(),
                      style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal*5 , color: Color(0xFF963E64)),
                    ),
                  ),
                ),
                SizedBox(
                  height: space[index].meta == null ?SizeConfig.safeBlockVertical*1:SizeConfig.safeBlockVertical*3 ,
                ),
                Container(
                  child: Text(
                    space[index].meta == null ? " " : space[index].meta,
                    style: TextStyle(
                        fontSize:  SizeConfig.safeBlockHorizontal*4.5,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical*1 ,
                ),
                Container(
                  child: Text(
                    space[index].description,
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal*4.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical*2 ,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      'Spaces',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8D6E80),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sigma Tenant'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? spaceList(snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
