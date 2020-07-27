import 'package:github_user_list/data/user.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  //////////////////////////////////////////////////
  ///               Fields
  //////////////////////////////////////////////////
  List<User> users;

  //////////////////////////////////////////////////
  ///               Controllers
  //////////////////////////////////////////////////
  final _usersController = PublishSubject<List<User>>();

  //////////////////////////////////////////////////
  ///               Getters
  //////////////////////////////////////////////////
  get usersStream => _usersController.stream;

  //////////////////////////////////////////////////
  ///               Methods
  //////////////////////////////////////////////////
  HomeBloc() : users = [];

  getUserListStub(int since, int perPage) {
    users.addAll(List.generate(perPage, (index) => User.createDummyUser()));
    _usersController.add(users);
  }

  void dispose() {
    users = [];
    _usersController.close();
  }
}
