import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:json_gen_form/json_gen_form.dart';
import 'package:turkish_marketer/extentions.dart';
import 'package:turkish_marketer/utils/routing/navigation_service.dart';
import 'package:turkish_marketer/utils/routing/routes.dart';

import '../../../di.dart';

final loginViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return LoginViewModel();
});

class LoginViewModel extends ChangeNotifier {
  late BuildContext context;

  //final AuthUseCase _authService = AuthUseCase(ApiService(Dio()));
  // final GlobalKey key = GlobalKey<JsonGenFormState>();
  bool isLoading = false;
  String? errorMessage;

  String email = '';
  String password = '';

  bool? isEmailValid;
  bool? isPasswordValid;

  String emailErrorText = '';
  String passwordErrorText = '';

  bool isObscureText = true;

  final List<dynamic> data = [
    {
      "type": "group",
      "label": "رقم 1",
      "field": "group1",
      "children": [
        {
          "type": "row",
          "gutter": 20,
          "children": [
            {
              "type": "col",
              "child": {
                "type": "text",
                "field": "name",
                "label": "اسم المجموعة 1",
              }
            },
            {
              "type": "col",
              "child": {"type": "number", "field": "num", "label": "عدد الأشخاص"}
            }
          ]
        },
        {"type": "text", "field": "manage", "label": "مدير"}
      ]
    },
    {
      "type": "text",
      "field": "name",
      "label": "اسم",
      "value": "المجاور لاو وانغ",
      "readonly": true,
      "placeholder": "الرجاء إدخال اسمك",
      "rules": [
        {"required": true, "message": "الرجاء إدخال اسمك"}
      ]
    },
    {
      "type": "password",
      "field": "password",
      "label": "كلمة المرور",
      "value": null,
      "placeholder": "الرجاء إدخال كلمة المرور الخاصة بك",
      "rules": [
        {"required": true, "message": "الرجاء إدخال كلمة المرور الخاصة بك"},
        {
          "pattern": "^[a-zA-Z0-9_-]{6,16}\$",
          "message": "يجب أن تكون كلمة المرور بطول 6-16 حرفًا، مع أحرف وأرقام وعلامات سفلية وعلامات ناقص."
        }
      ]
    },
    {
      "type": "textarea",
      "field": "remark",
      "label": "التعريف بالنفس",
      "value": null,
      "placeholder": "يرجى تقديم نفسك بإيجاز",
      "rules": []
    },
    {
      "type": "number",
      "field": "age",
      "label": "age",
      "value": null,
      "placeholder": "الرجاء إدخال عمرك",
      "rules": [
        {"required": true, "message": "الرجاء إدخال عمرك"},
        {"min": 18, "message": "يجب أن يكون عمرك أكثر من 18 عامًا"}
      ]
    },
    {
      "type": "select",
      "field": "province",
      "label": "مقاطعة",
      "value": 1,
      "placeholder": "الرجاء اختيار المحافظة",
      "options": [
        {"label": "شانشي", "value": 1},
        {"label": "شنشي", "value": 2},
        {"label": "شاندونغ", "value": 3}
      ]
    },
    {
      "type": "cascade",
      "field": "city",
      "label": "مدينة",
      "value": null,
      "placeholder": "الرجاء تحديد مدينتك",
      "options": [
        {
          "label": "شانشي",
          "value": 1,
          "children": [
            {
              "label": "تاييوان",
              "value": 11,
              "children": [
                {"label": "منطقة متجر صغيرة", "value": 111},
                {"label": "منطقة ينغزي", "value": 112}
              ]
            },
            {"label": "لوليانغ", "value": 12},
            {"label": "داتونغ", "value": 13}
          ]
        },
        {
          "label": "شنشي",
          "value": 2,
          "children": [
            {"label": "شيآن", "value": 21},
            {"label": "شيانيانغ", "value": 22}
          ]
        }
      ]
    },
    {
      "type": "date",
      "field": "birthday",
      "label": "عيد ميلاد",
      "value": null,
      "placeholder": "الرجاء تحديد تاريخ ميلادك"
    },
    {
      "type": "radio",
      "field": "sex",
      "label": "جنس",
      "value": null,
      "options": [
        {"label": "ذكر", "value": 1},
        {"label": "أنثى", "value": 2},
        {"label": "اخرى", "value": 0}
      ]
    },
    {
      "type": "checkbox",
      "field": "hobby",
      "label": "هواية",
      "value": [],
      // "direction": "vertical",
      "options": [
        {"label": "كرة السلة", "value": "basketball"},
        {"label": "كرة القدم", "value": "football"},
        {"label": "تنس الريشة", "value": "badminton"}
      ],
      "rules": [
        {"required": true, "message": "الرجاء اختيار هواية"}
      ]
    },
    {
      "type": "switch",
      "field": "agree",
      "label": "الموافقة على الاتفاقية",
      "value": null,
      "rules": [
        {"required": true, "message": "الرجاء الموافقة على الاتفاقية"}
      ]
    },
    {
      "type": "media",
      "field": "media",
      "label": "تحميل الصور والفيديوهات",
      "value": null,
      "rules": null,
      "multiple": true
    }
  ];

  obscureText() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  validateEmail(String value) {
    email = value.trim();
    isEmailValid = value.isNotEmpty;

    if (isEmailValid ?? false) {
      emailErrorText = '';

      if (!value.isValidEmail()) {
        isEmailValid = false;
        emailErrorText = 'please_enter_valid_email'.localized();
      } else {
        emailErrorText = '';
      }
    } else {
      emailErrorText = 'email_required'.localized();
    }

    notifyListeners();
  }

  validatePassword(String value) {
    password = value.trim();
    isPasswordValid = value.isNotEmpty; //&& value.length > 6;

    if (isPasswordValid ?? false) {
      passwordErrorText = '';
    } else {
      passwordErrorText = 'password_required';
    }

    notifyListeners();
  }

  bool checkValid() {
    return ((isEmailValid ?? false) && (isPasswordValid ?? false)) ? true : false;
  }

  Future<void> login(WidgetRef ref) async {
    sl<NavigationService>().navigateToAndRemove(tabBarScreen);

    // isLoading = true;
    // errorMessage = null;
    //notifyListeners();
    // LoadingAlertDialog.show(
    //   context,
    //   title: "login".localized(),
    // );

    //try {
    //   final response = await sl<AuthRepository>().login(email, password);

    //   if (response.result?.emailVerified == false) {
    //     var verificationViewModel = ref.watch(verificationViewModelProvider);
    //     verificationViewModel.email = email;

    //     sl<LocalRepo>().setUserObject(response.result!);

    //     sl<Dio>().options.headers.addAll(
    //       {'Authorization': 'Bearer ${response.result?.token}'},
    //     );

    //     sl<NavigationService>().navigateTo(verificationScreen);
    //   } else if (response.result?.hasCompany == false) {
    //     sl<NavigationService>().navigateTo(addCompanyScreen);
    //   } else if (response.status?.success == true) {
    //     sl<NavigationService>().navigateToAndRemove(tabBarScreen);
    //   }
    // } catch (e) {
    //   log('errorMessage : ${e.toString()}');
    //   errorMessage = e.toString();
    //   notifyListeners();
    // } finally {
    //   isLoading = false;
    //   notifyListeners();
    //   LoadingAlertDialog.dismiss();
    // // }
  }
}
