import 'dart:html';
import 'package:meta/dart2js.dart' as dart2js;

class UserCard extends HtmlElement {
  @dart2js.tryInline
  factory UserCard() {
    throw UnsupportedError("Ha! Just like HtmlElement.");
  }

  @dart2js.tryInline
  factory UserCard._() {
    throw UnsupportedError("_ constructor is not supported yet.");
  }

  @override
  @dart2js.tryInline
  UserCard.created() : super.created();

  @dart2js.tryInline
  static userCardFactory() {
    return UserCard.created();
  }
}

UserCard userCardProvider() {
  return UserCard.created();
}

void main() {
  // Just making sure Dart is running well on the browser.
  querySelector('#output')?.text = 'Your Dart app is running.';

  if (window.customElements == null) {
    print("Web Components is NOT available on this browser!");
  } else {
    print("Web Components IS available on this browser!");

    try {
      window.customElements!.define('user-card', UserCard);
    } catch (e) {
      // Are we even passing the default constructor?
      print("Default (factory) constructor fails: $e");
    }

    try {
      window.customElements!.define('user-card', UserCard._);
    } catch (e) {
      print("Another non-default factory constructor fails: $e");
    }

    try {
      window.customElements!.define('user-card', UserCard.created);
    } catch (e) {
      print("Named non-factory constructor fails: $e");
    }

    try {
      window.customElements!.define('user-card', UserCard.userCardFactory);
    } catch (e) {
      print("Static method that returns a new instance fails: $e");
    }

    try {
      window.customElements!.define('user-card', userCardProvider);
    } catch (e) {
      print("Provider function that returns a new instance fails: $e");
    }
  }
}
