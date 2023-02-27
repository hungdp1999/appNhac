class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  static FirebaseService instance = FirebaseService();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();
}