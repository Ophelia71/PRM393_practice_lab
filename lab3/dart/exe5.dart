class Settings{
  String theme;
  String language;

  Settings._internal(this.theme, this.language);

  static Settings instance = Settings._internal('dark', 'Vietnamese');

  factory Settings(){
    return instance;
  }
}

void main(){
  Settings a = Settings();
  Settings b = Settings();

  print(identical(a, b));
}