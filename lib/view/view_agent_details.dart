import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:finalproject1/service/api.dart';
import 'package:finalproject1/model/model_agentdet.dart';

class DetailPage extends StatefulWidget {
  final uuid;
  final String name;
  final String background;
  final String potrait;
  const DetailPage({ Key? key, required this.uuid, required this.name, required this.background, required this.potrait}) : super(key: key);
  
  @override
  State<DetailPage> createState() => _UserDetailState();
}

TextStyle skillDex = const TextStyle(
  color: Colors.white,
);

TextStyle nama = const TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.bold,
  letterSpacing: 5,
  color: Colors.red,
  shadows: [
    Shadow(
      offset: Offset(2, 2), // Offset of the shadow
      blurRadius: 4, // Blur radius of the shadow
      color: Colors.black, // Color of the shadow
    ),
  ],
  // foreground: Paint()
  //         ..style = PaintingStyle.stroke
  //         ..strokeWidth = 3
  //         ..color = Colors.blueGrey,
);

class _UserDetailState extends State<DetailPage> {
  Future<void> _setBackground() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('background', widget.background);
  }

  @override
  void initState(){
    super.initState();
    _setBackground();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: NetworkImage(widget.background), fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.name.toString() + " Details"),
              Image.network(widget.potrait, height: 70,)
            ],
          ),
          // leading: Image.network(widget.potrait),
        ),body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDetailedUsersBody(widget.uuid),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget _buildDetailedUsersBody(String uuid){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadDetailAgent(uuid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingSection();
        }
        if (snapshot.hasData && snapshot.data != null) {
          AgentDetails detailAgent = AgentDetails.fromJson(snapshot.data);
          return _buildSuccessSection(context, detailAgent);
        }
        return _buildErrorSection(); // Handle the case when data is null
      },
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Error"),
  );
}

Widget _buildSuccessSection(BuildContext context, AgentDetails agent){
  return Center(
    child: Column(
      children: [
        Container(
          // width: 600,
          child: Image.network(agent.data!.fullPortraitV2!),
        ),
        Container(
          width: 400,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(agent.data!.displayName!, style: nama),
              SizedBox(height: 15),
              Text(agent.data!.role!.displayName!),
              Text(agent.data!.description!, textAlign: TextAlign.justify,),
            ],
          ),
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  agent.data!.abilities!.length,
                  (index) => Container(
                    width: 100,
                    child: InkWell(
                      onTap: () {
                        showDialog(context: context, 
                        builder: (context) => AlertDialog(
                          title: Text(agent.data!.abilities![index].displayName!),
                          content: Text(agent.data!.abilities![index].description!, textAlign: TextAlign.justify,),
                        ),);
                      },
                      child: Column(
                        children: [
                          Image.network(
                            agent.data?.abilities?[index].displayIcon ?? '',
                            width: 50,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.warning_rounded, size: 50,)
                          ),
                          Text(
                            agent.data!.abilities![index].displayName!,
                            style: skillDex,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     InkWell(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Image.network(agent.data!.abilities![0].displayIcon!, width: 50, height: 50),
        //           Text(agent.data!.abilities![0].displayName!, style: skillDex, textAlign: TextAlign.justify,),
        //           // Text(agent.data!.abilities![0].description!, style: skillDex, textAlign: TextAlign.justify,),
        //         ],
        //       ),
        //     ),
        //     InkWell(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Image.network(agent.data!.abilities![1].displayIcon!, width: 50, height: 50),
        //           Text(agent.data!.abilities![1].displayName!, style: skillDex, textAlign: TextAlign.justify,),
        //           // Text(agent.data!.abilities![1].description!, style: skillDex, textAlign: TextAlign.justify,),
        //         ],
        //       ),
        //     ),
        //     InkWell(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Image.network(agent.data!.abilities![2].displayIcon!, width: 50, height: 50),
        //           Text(agent.data!.abilities![2].displayName!, style: skillDex, textAlign: TextAlign.justify,),
        //           // Text(agent.data!.abilities![2].description!, style: skillDex, textAlign: TextAlign.justify,),
        //         ],
        //       ),
        //     ),
        //     InkWell(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Image.network(agent.data!.abilities![3].displayIcon!, width: 50, height: 50),
        //           Text(agent.data!.abilities![3].displayName!, style: skillDex, textAlign: TextAlign.justify,),
        //           // Text(agent.data!.abilities![3].description!, style: skillDex, textAlign: TextAlign.justify,),
        //         ],
        //       ),
        //     ),
            
        //   ],
        // )
      ],
    ),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}