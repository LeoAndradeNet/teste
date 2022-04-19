import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SocialtestFirebaseUser {
  SocialtestFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

SocialtestFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SocialtestFirebaseUser> socialtestFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<SocialtestFirebaseUser>(
            (user) => currentUser = SocialtestFirebaseUser(user));
