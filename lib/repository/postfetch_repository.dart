import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_counter_app/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostFetchRepository {
  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http
          .get(
            Uri.parse("https://jsonplaceholder.typicode.com/comments"),
            headers: {
              'Accept': 'application/json',
              'User-Agent':
                  'YourAppName/1.0', // Some APIs block unknown clients
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body
            .map(
              (e) => PostModel(
                postId: e["postId"] as int,
                id: e["id"] as int,
                name: e["name"] as String,
                body: e["body"] as String,
                email: e["email"] as String,
              ),
            )
            .toList();
      } else {
        throw Exception("Failed to load posts: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } on TimeoutException {
      throw Exception("Request timed out");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
