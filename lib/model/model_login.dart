import 'package:hive/hive.dart';

part 'model_login.g.dart';

@HiveType(typeId:0)
class loginData extends HiveObject{
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password;

  loginData({required this.username, required this.password});

}