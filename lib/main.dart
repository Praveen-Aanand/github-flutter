import 'package:flutter/material.dart';
import 'package:github_flutter/models/git_repo.dart';
import 'package:github_flutter/services/repo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git Repos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Git Repos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GitRepo _repos = GitRepo();

  @override
  void initState() {
    super.initState();
    _refersh();
  }

  void _refersh() async {
    GitRepo temp = await RepoList().loadRepo();
    setState(() {
      _repos = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_repos.items != null && _repos.items!.isNotEmpty)
              ..._repos.items!.map((e) => RepoContainer(data: e,)).toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refersh,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class RepoContainer extends StatelessWidget {
  final Items data;
  const RepoContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.symmetric(vertical:4, horizontal: 6),
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 179, 179, 179),width: .5,
       
       )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("${data.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              const Spacer(),
              const Icon(Icons.star,color: Colors.yellow,),
              Text("${data.stargazersCount}")
            ],
          ),
          Text("Discription: ${data.description}"),
          const SizedBox(height: 7,),
          Row(children: [ClipRRect(
             borderRadius: BorderRadius.circular(100),
             child: Image.network(data.owner!.avatarUrl! , width: 30, height: 30,),),Text("${data.owner!.login}")],)
        ],
      ),
    );
  }
}
