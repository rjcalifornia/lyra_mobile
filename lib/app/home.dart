import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lyra_mobile/widgets/lyra_app.dart';
import 'package:lyra_mobile/widgets/screens/errors/ErrorScreen.dart';
import 'package:lyra_mobile/widgets/screens/forms/AddResultsForm.dart';
import 'package:lyra_mobile/widgets/screens/forms/RequestAuthenticationForm.dart';
import 'package:lyra_mobile/widgets/screens/reports/device_transmissions.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       locale: Locale('es', 'SV'),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('es', 'ES'),
            const Locale('es', 'SV'),
            const Locale('de', 'DE'),
            const Locale('fr', 'FR'),
            const Locale('zh', 'HK')
          ],

           initialRoute: '/',

           routes: {
            '/not-allowed/' : (ctx) => ErrorScreenPage(),
            '/' : (ctx) => LyraApp(),
            '/options/register-votes/' : (ctx) => AddResultsFormWidget(),
            '/reports/get-transmissions/' : (ctx) => ReporteEnviosWidget(),
            '/options/authenticate-device/' : (ctx) => RequestAuthenticationForm(),
            
          },
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(

                /// Si no encuentra la ruta en el [getAppRoutes] redirecciona al [widget] [App404]
                builder: (BuildContext context) => ErrorScreenPage(),
                maintainState: false);
          }
    );
  }
}