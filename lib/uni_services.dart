import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification/home.dart';
import 'package:notification/navigatorKey.dart';
import 'package:notification/screens/home_screen.dart';
import 'package:uni_links/uni_links.dart';

class UniService{
static String _code='';
static String get code => _code;
// static bool get hascode => _code.isNotEmpty;

static void reset() => _code ='';

   static init() async{
        try{
          final Uri? uri = await getInitialUri();
          uniHandler(uri);
        }on PlatformException{
          log("failed...");
        }on FormatException{
          log("wrong...");
        }
        uriLinkStream.listen((Uri? uri) async{
          uniHandler(uri);
        },onError: (error){
          log("link error  $error");
        }
        );
      }
       static uniHandler(Uri? uri){
        if(uri==null || uri.queryParameters.isNotEmpty) return;
        Map<String,String> param = uri.queryParameters;
        String recievedCode = param['code'] ?? '';

        if(recievedCode == "green"){
          Navigator.push(Context.context!,MaterialPageRoute(builder: (_)=> Home()));
        }else{
            Navigator.push(Context.context!, MaterialPageRoute(builder: (_)=>HomeScreen()));
        }
   }
}