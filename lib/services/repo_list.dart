
import 'dart:convert';

import 'package:github_flutter/models/git_repo.dart';
import 'package:http/http.dart' as http;

class RepoList {
  Future<GitRepo> loadRepo() async {
    http.Response response=await http.get(Uri.parse("https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc"));
    if(response.statusCode==200){
       return GitRepo.fromJson(jsonDecode(response.body));
    }else{
      throw "fetching error ${ response.statusCode}";
    }
  }
}