class University {
  String _name;
  String _city;
  int? _ranking;

  University(this._name, this._city, [this._ranking]);

  String get name => _name;
  String get city => _city;
  int? get ranking => _ranking;
}

