
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService{
  Future saveQuotes (List<String> _list) async{
    final _preference = await SharedPreferences.getInstance();
    await _preference.setStringList('quote text', _list);
  }

  Future<List<String>> getQuotes () async{
    final _preference = await SharedPreferences.getInstance();
    final savedquotes = _preference.getStringList('quote text') == null ? List<String>() : _preference.getStringList('quote text');
    return savedquotes;
  }
}