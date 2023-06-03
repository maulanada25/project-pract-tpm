import 'package:flutter/material.dart';

import 'package:finalproject1/service/api.dart';
import 'package:finalproject1/model/model_weapondet.dart';

class WeapDetailsPage extends StatefulWidget {
  final uuid;
  final String name;
  const WeapDetailsPage({ Key? key, required this.uuid, required this.name }) : super(key: key);

  @override
  State<WeapDetailsPage> createState() => _WeaponDetailsState();
}

class _WeaponDetailsState extends State<WeapDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(widget.name + " Details")
      ),
      body: _buildListWeaponBody(widget.uuid),
    ));
  }
}

Widget _buildListWeaponBody(String uuid){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadWeaponDetails(uuid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){//snapshot digunakan untuk mengecek data apakah ada atau tidak
        if(snapshot.hasError){
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          WeaponDetails weapon = WeaponDetails.fromJson(snapshot.data);
          return _buildSuccessSection(weapon, uuid);
        }
        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildSuccessSection(WeaponDetails weapon, String uuid){
  // int index = weapon.getIndexByName(uuid);
  List<String> demeg = ['Head', 'Body', 'Leg'];
  return Center(
    child: Column(
      children: [
        Container(
          width: 600,
          child: Image.network(weapon.data!.displayIcon!),
        ),
        Container(
          width: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(weapon.data!.displayName!, style: TextStyle(color: Colors.white ),),
              Column(
                children: [
                  Text("Fire Rate : " + weapon.data!.weaponStats!.fireRate.toString(), style: TextStyle(color: Colors.white ),),
                  Text("Magazine Size : " + weapon.data!.weaponStats!.magazineSize.toString(), style: TextStyle(color: Colors.white ),)
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Error"),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}