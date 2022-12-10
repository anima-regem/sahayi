import 'package:flutter/material.dart';
import 'package:sahayi_study/pages/about_page.dart';
import 'package:sahayi_study/pages/downloads_page.dart';
import 'package:sahayi_study/pages/modules_page.dart';
import '../helper/data_variables.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String time = (hour > 12) ? "evening" : "morning";
    var subjectData = data;
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                  child: Text(
                "Sahayi",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              )),
              ListTile(
                iconColor: Colors.red[800],
                textColor: Colors.red[800],
                leading: const Icon(Icons.home_filled),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.file_download_outlined),
                title: const Text('Downloads'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DownloadPage()));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()));
                },
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomCenter,
                child: const Text("Made with ❤ by StudioOne"),
              )),
            ],
          ),
        ),
      ),
      body: HomeBody(time: time, subjectData: subjectData),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    required this.time,
    required this.subjectData,
  }) : super(key: key);

  final String time;
  final List<Map<String, dynamic>> subjectData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                    icon: const Icon(Icons.menu_sharp),
                    iconSize: 36,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(36),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Good$time!",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            "Ready to learn?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ]),
                  ),
                )
              ],
            ),
          )),
          Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: SubjectData(subjectData: subjectData)),
        ],
      ),
    );
  }
}

class SubjectData extends StatelessWidget {
  const SubjectData({
    Key? key,
    required this.subjectData,
  }) : super(key: key);

  final List<Map<String, dynamic>> subjectData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          itemBuilder: ((context, index) {
            return ListTile(
              leading: const Icon(Icons.folder_open_sharp),
              title: Text("${subjectData[index]['name']}"),
              trailing: const Icon(Icons.arrow_right_sharp),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (ModulesPage(dataIndex: index)))),
            );
          }),
          separatorBuilder: (context, index) => (const Divider()),
          itemCount: subjectData.length),
    );
  }
}
