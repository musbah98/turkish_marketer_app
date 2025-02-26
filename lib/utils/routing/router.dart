import 'package:flutter/material.dart';
import 'package:turkish_marketer/screens/allTabs/categories/category_filter/category_filter_screen.dart';
import 'package:turkish_marketer/screens/allTabs/categories/sub_categories/sub_categories_screen.dart';
import 'package:turkish_marketer/screens/allTabs/home/post_details/post_details_screen.dart';
import 'package:turkish_marketer/screens/profile/Index_of_products/Index_of_products_screen.dart';
import 'package:turkish_marketer/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:turkish_marketer/screens/profile/profile_screen.dart';
import 'package:turkish_marketer/screens/auth/addCompany/add_company_screen.dart';

import '../../screens/allTabs/companies/company_ details/company_details_screen.dart';
import '../../screens/allTabs/companies/rfq_screen/rfq_screen.dart';
import '../../screens/allTabs/home/home_screen.dart';
import '../../screens/auth/login/login_screen.dart';
import '../../screens/auth/signup/signup_screen.dart';
import '../../screens/auth/verification/verification_screen.dart';
import '../../screens/on_boarding/on_boarding_screen.dart';
import '../../screens/pre_app/pre_app_screen.dart';
import '../../screens/profile/agents/agents_screen.dart';
import '../../screens/profile/change_password/change_password_screen.dart';
import '../../screens/search/search_screen.dart';
import '../../screens/tab_bar/tab_bar_screen.dart';
import '../../screens/web_view_app.dart';
import 'routes.dart';
/*
  class provides a central location for defining and generating routes in a Flutter application.
  It maps route names to their corresponding widget builders using a switch statement and returns appropriate MaterialPageRoute objects for navigation.
 */

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case preAppScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: preAppScreen),
          builder: (_) => const PreAppScreen(),
        );

      case onBoardingScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: onBoardingScreen),
          builder: (_) => const OnBoardingScreen(),
        );

      case loginScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: loginScreen),
          builder: (_) => const LoginScreen(),
        );

      case signupScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: signupScreen),
          builder: (_) => const SignupScreen(),
        );

      case verificationScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: verificationScreen),
          builder: (_) => const VerificationScreen(),
        );

      case addCompanyScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: verificationScreen),
          builder: (_) => const AddCompanyScreen(),
        );

      case webViewApp:
        return MaterialPageRoute(
          settings: const RouteSettings(name: webViewApp),
          builder: (_) => const WebViewApp(),
        );

      case tabBarScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: tabBarScreen),
          builder: (_) => const TabBarScreen(),
        );

      case homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: homeScreen),
          builder: (_) => const HomeScreen(),
        );

      case subCategoriesScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: subCategoriesScreen),
          builder: (_) => const SubCategoriesScreen(),
        );
      case categoryFilterScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: categoryFilterScreen),
          builder: (_) => const CategoryFilterScreen(),
        );

      case profileScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: profileScreen),
          builder: (_) => const ProfileScreen(),
        );

      case searchScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: searchScreen),
          builder: (_) => const SearchScreen(),
        );

      case postDetailsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: postDetailsScreen),
          builder: (_) => const PostDetailsScreen(),
        );

      case companyDetailsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: companyDetailsScreen),
          builder: (_) => const CompanyDetailsScreen(),
        );

      case rfqScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: rfqScreen),
          builder: (_) => const RfqScreen(),
        );

      case agentsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: agentsScreen),
          builder: (_) => const AgentsScreen(),
        );

      case indexOfProductsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: indexOfProductsScreen),
          builder: (_) => const IndexProductsScreen(),
        );

      case editProfileScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: editProfileScreen),
          builder: (_) => const EditProfileScreen(),
        );

      case changePaswsordScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: changePaswsordScreen),
          builder: (_) => const ChangePaswsordScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
