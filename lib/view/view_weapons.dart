import 'package:finalproject1/view/view_weapon_details.dart';
import 'package:flutter/material.dart';

import 'package:finalproject1/service/api.dart';
import 'package:finalproject1/model/model_weapons.dart';

class WeaponsView extends StatefulWidget {
  const WeaponsView({ Key? key }) : super(key: key);

  @override
  State<WeaponsView> createState() => _WeaponsViewState();
}

class _WeaponsViewState extends State<WeaponsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        child: _buildListWeaponBody(),
      ),
    ));
  }
}

Widget _buildListWeaponBody(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadWeapons(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){//snapshot digunakan untuk mengecek data apakah ada atau tidak
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            Weapons weapons = Weapons.fromJson(snapshot.data);
            return _buildSuccesSection(context, weapons);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

Widget _buildSuccesSection(BuildContext context, Weapons data){
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10.0,
              // mainAxisSpacing: 10.0,
              childAspectRatio: 2,
            ),
            itemCount: data.data!.length,
            itemBuilder: (BuildContext context, int index){
              return _buildWeaponItem(context, data.data![index]);
            }
          ),
        ],
      ),
    ),
  );
}

Widget _buildWeaponItem(BuildContext context, Data data){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    height: 10,
    width: 10,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeapDetailsPage(
                uuid: data.uuid,
              ),
            ),
          );
      },
      child: Container(
        child: Column(
          children: [
            Container(
              // width: 300,
              // height: 120,
              child: Image.network(data.displayIcon!, width: 300, height: 100),
            ),
            Text(data.displayName!),
          ],
        ),
      ),
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Ada Error nih"),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}