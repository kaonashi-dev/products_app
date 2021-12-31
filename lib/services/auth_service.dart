import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{

   final String _baseUrl = dotenv.get('FIREBASE_AUTH_URL');
   final String _firebaseToken = dotenv.get('FIREBASE_TOKEN_ID');

   final storage = const FlutterSecureStorage();

   Future <String?> createUser( String? email, String? pass ) async {

      final Map<String, dynamic> authData = {
         'email': email,
         'password': pass,
      };

      final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
         'key': _firebaseToken
      });
      final response = await http.post( url, body: json.encode(authData) );
      final Map<String, dynamic> decodedData = json.decode(response.body );

      // ignore: avoid_print
      print(decodedData);
      if (decodedData.containsKey('idToken')) {
         await storage.write(key: 'idtoken', value: decodedData['idToken']);
         return null;
      } else {
         return decodedData['error']['message'];
      }

   }

   Future <String?> login( String? email, String? pass ) async {

      final Map<String, dynamic> authData = {
         'email': email,
         'password': pass,
      };

      final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
         'key': _firebaseToken
      });
      final response = await http.post( url, body: json.encode(authData) );
      final Map<String, dynamic> decodedData = json.decode(response.body );

      // ignore: avoid_print
      print(decodedData);
      if (decodedData.containsKey('idToken')) {
         await storage.write(key: 'idtoken', value: decodedData['idToken']);
         return null;
      } else {
         return decodedData['error']['message'];
      }

   }

   Future logout() async {
      await storage.delete(key: 'idtoken');
   }

   Future<String> getIdtoken() async {
      return await storage.read(key: 'idtoken') ?? '';
   }

}