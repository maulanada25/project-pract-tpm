import 'package:finalproject1/view/view_agent_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalproject1/service/api.dart';
import 'package:finalproject1/model/model_agents.dart';

class AgentsView extends StatefulWidget {
  const AgentsView({Key? key}) : super(key: key);

  @override
  State<AgentsView> createState() => _AgentsViewState();
}

class _AgentsViewState extends State<AgentsView> {
  String? _background;
  // bool isBg = false;

  Future<void> _getBackground() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _background = prefs.getString("background");
    });
  }

  @override
  void initState(){
    super.initState();
    _background = "";
    _getBackground();
  }

  // BoxDecoration isBg = BoxDecoration(
  //   color: Colors.red,
  //         image: DecorationImage(image: NetworkImage(_background))
  // );

  @override
  Widget build(BuildContext context) {
      if(_background != null && _background != ""){
        print(_background);
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(image: NetworkImage(_background!))
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(child: _buildListAgentBody())
            ),
          ),
        );
      }else{
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              // image: DecorationImage(image: NetworkImage(_background))
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(child: _buildListAgentBody())
            ),
          ),
        );
      }
  }

  Widget _buildErrorSection(){
    return Container(
      child: Text("Ada Error nih"),
    );
  }

  Widget _buildLoadingSection(){
    return CircularProgressIndicator();
  }

  Widget _buildListAgentBody(){
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(image: AssetImage('images/download.jpg'), fit: BoxFit.fill)
      // ),
      child: FutureBuilder(
        future: ApiDataSource.instance.loadAgents(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){//snapshot digunakan untuk mengecek data apakah ada atau tidak
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            Agents agents = Agents.fromJson(snapshot.data);
            return _buildSuccessSection(context, agents);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildSuccessSection(BuildContext context, Agents data) {
    List<Data> playableAgents = data.data!.where((item) => item.isPlayableCharacter == true).toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5)
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                ),
                itemCount: playableAgents.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildAgentItem(context, playableAgents[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgentItem(BuildContext context, Data data) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                uuid: data.uuid,
                name: data.displayName.toString(),
                background: data.background.toString(),
                potrait: data.killfeedPortrait!.toString(),
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 120,
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data.displayIconSmall!),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(data.displayName!, style: TextStyle(color: Colors.black),),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}