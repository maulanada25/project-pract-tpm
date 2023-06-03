import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class grupmemb{
  String name;
  String nim;
  String image;
  String message;

  grupmemb({required this.name, required this.nim, required this.image, required this.message});
}

class _ProfilePageState extends State<ProfilePage> {

  var groupmembList = [
    grupmemb(
        name: "Maulana Daffa Ardiansyah",
        nim: "123200130",
        image: "images/3x4red.jpg",
        message : "Insyaallah"
    ),
    grupmemb(
        name: "Juan Azhar Adviseta Setiawan",
        nim: "123200139",
        image: "images/Web_Juan Azhar.jpg",
        message : "Alhamdulillah"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: groupmembList.length,
            itemBuilder: (context, index) {
              grupmemb memb = groupmembList[index];
              return Card(
                child: ListTile(
                  leading: Image.asset(memb.image,
                      width: 50, height: 50, fit: BoxFit.cover,),
                  title: Text(memb.name),
                  subtitle: Text(memb.nim),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Text("Personal Info", textAlign: TextAlign.center),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(memb.image),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(height: 15),
                            Container(
                              child: Column(
                                children: [
                                  Text(memb.name),
                                  SizedBox(height:10),
                                  Text(memb.nim),
                                  SizedBox(height:10),
                                  // Text("Message :"),
                                  Text(memb.message)
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              );
            },
          ),
        )
    ));
  }
}