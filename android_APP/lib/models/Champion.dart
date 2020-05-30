
class Champion {
  String _name;
  Champion(String name){
    this._name = name;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

}