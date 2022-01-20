import 'package:firebase_core/firebase_core.dart';

class newDatabase{
Future<void> addDatabase(String projectName,String my_appId,String my_apiKey ,String my_messagingSenderId,String my_projectId) async {

await Firebase.initializeApp(
    name: projectName,
    options:  FirebaseOptions(
        appId: my_appId,
        apiKey: my_apiKey,
        messagingSenderId: my_messagingSenderId,
        projectId: my_projectId
    )
);

}


}