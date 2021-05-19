import '../Model/saved_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService{
  Future saveQuotes (SavedItems quotes) async{
    final _preference = await SharedPreferences.getInstance();
    await _preference.setStringList('quote text', quotes.savedquotes);
    await _preference.setStringList('quote id', quotes.quotesid);
  }

  Future<SavedItems> getQuotes () async{
    final _preference = await SharedPreferences.getInstance();
    final savedquotes = _preference.getStringList('quote text') == null ? List<String>() : _preference.getStringList('quote text');
    final quotesid = _preference.getStringList('quote id') == null ? List<String>() : _preference.getStringList('quote id');

    return SavedItems(savedquotes: savedquotes, quotesid: quotesid);
  }
}