
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:technical_flutter/services/post_service.dart';

@GenerateMocks([http.Client])
main() {
  late PostService postService;

  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    const MethodChannel('dev.fluttercommunity.plus/connectivity')
        .setMethodCallHandler((MethodCall methodCall) async {
      return ['wifi'];
    });
  });

  tearDownAll(() {
    const MethodChannel('dev.fluttercommunity.plus/connectivity')
        .setMethodCallHandler(null);
  });
  test("calling fetchPosts to return not null", () async {
    final mockClient = MockClient((request) async {
    final responseJson = jsonEncode([
      {"userId": 9, "id": 86, "title": "placeat quia et porro iste", "body": "quasi excepturi consequaturt optio"},
      {"userId": 9,"id": 87, "title": "nostrum quis quasi placeat", "body": "eos et molestiae"},
      {"userId": 9, "id": 88, "title": "sapiente omnis fugit eos", "body": "consequatur omnis est praesentium"},
    ]);
    return http.Response(responseJson, 200);
    });
    postService = PostService(client: mockClient);

    //Act
    final actual = await postService.fetchPosts();
    //Assert
    expect(actual, isNotNull);
    expect(actual.length, 3);
    expect(actual[0].title, "placeat quia et porro iste");
  });

  test("calling fetchPostById by passing valid value", () async {
    final mockClient = MockClient((request) async {
      final responseJson = jsonEncode({
          "userId": 1, "id": 3, "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
          "body": "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"
        });
      return http.Response(responseJson, 200);
    });
    postService = PostService(client: mockClient);
    //Arrange
    final actual = await postService.fetchPostById(3);
    //Assert
    expect(actual, isNotNull);
  });
  test("calling fetchComments by passing valid value", () async {
    //Act
    final actual = await postService.fetchComments(postId: 3);
    //Assert
    expect(actual, isNotNull);
  });

}
