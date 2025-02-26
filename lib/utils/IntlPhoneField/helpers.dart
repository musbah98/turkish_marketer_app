import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

import 'countries.dart';

bool isNumeric(String s) => s.isNotEmpty && int.tryParse(s.replaceAll("+", "")) != null;

String removeDiacritics(String str) {
  var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  for (int i = 0; i < withDia.length; i++) {
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }

  return str;
}

extension CountryExtensions on List<Country> {
  List<Country> stringSearch(String search) {
    search = removeDiacritics(search.toLowerCase());
    return where(
      (country) => isNumeric(search) || search.startsWith("+")
          ? country.dialCode.contains(search)
          : removeDiacritics(country.name.replaceAll("+", "").toLowerCase()).contains(search) ||
              country.nameTranslations.values
                  .any((element) => removeDiacritics(element.toLowerCase()).contains(search)),
    ).toList();
  }
}

Future<String?> getPhoneNumberExapmle(String value) async {
  return PhoneNumberUtil.getFormattedExampleNumber(value, PhoneNumberType.MOBILE, PhoneNumberFormat.INTERNATIONAL);
}

String? getCountryCodeByDialCode(String dialCode) {
  for (var country in countries) {
    if ('+${country.dialCode}' == dialCode) {
      return country.code; // Return ISO code
    }
  }
  return null; // Return null if not found
}

Future<String?> getFormattedPhoneNumber(String value) async {
  var text = await getPhoneNumberExapmle(value);
  List<String> listString = [];

  listString = text?.split(" ") ?? [];
  listString.removeAt(0);
  listString.join(" ");
  return listString.join(" ");
}
