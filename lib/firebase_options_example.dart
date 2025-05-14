import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class FirebaseOptionsExample {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'apiKey',
    appId: 'appId',
    messagingSenderId: 'messagingSenderId',
    projectId: 'projectId',
    storageBucket: 'storageBucket',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'apiKey',
    appId: 'appId',
    messagingSenderId: 'messagingSenderId',
    projectId: 'projectId',
    storageBucket: 'storageBucket',
    iosBundleId: 'iosBundleId',
  );
}
