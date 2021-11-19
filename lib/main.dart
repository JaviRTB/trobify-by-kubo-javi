import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './services/auth.dart';
import './screens/my_anouncements_screen.dart';
import './screens/upload_property.dart';
import './screens/wrapper.dart';
import './screens/propertyOnLoan_detail_screen.dart';
import './screens/propertyOnSell_detail_screen.dart';
import './screens/filter_screen.dart';
import './models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Trobify',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
        ),
        home: Wrapper(),
        routes: {
          PropertyOnLoanDetailScreen.routeName: (ctx) =>
              PropertyOnLoanDetailScreen(),
          PropertyOnSellDetailScreen.routeName: (ctx) =>
              PropertyOnSellDetailScreen(),
          FilterScreen.routeName: (ctx) => FilterScreen(),
          UploadPropertyScreen.routeName: (ctx) => UploadPropertyScreen(),
          MyAnnouncementsScreen.routeName: (ctx)=> MyAnnouncementsScreen(),
        },
      ),
    );
  }
}
