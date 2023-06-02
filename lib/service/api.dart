import 'base_net.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadAgents(){
    return BaseNetwork.get("agents");
  }

  Future<Map<String, dynamic>> loadDetailAgent(String uuid){
    return BaseNetwork.get("agents/"+uuid);
  }

  Future<Map<String, dynamic>> loadWeapons(){
    return BaseNetwork.get("weapons");
  }

  Future<Map<String, dynamic>> loadWeaponDetails(String uuid){
    return BaseNetwork.get("weapons/"+uuid);
  }
}