
class Profile {
  late String _title;
  late List<String> _options;

  Profile (String title, List<String> options) {
    setTitle(title);
    setOptions(options);
  }

  void setTitle(String title) {
    _title = title;
  }

  void setOptions(List<String> options) {
    if (options.isNotEmpty) {
      _options = options;
    }
    _options = [];
  }



}







