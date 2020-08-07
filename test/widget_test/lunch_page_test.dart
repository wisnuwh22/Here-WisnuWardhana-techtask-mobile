import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tech_task/application/providers/ingredient_provider.dart';
import 'package:tech_task/application/providers/recipe_provider.dart';
import 'package:tech_task/domain/settings/colors.dart';
import 'package:tech_task/domain/settings/constants.dart';
import 'package:tech_task/domain/settings/messages.dart';
import 'package:tech_task/presentation/screens/ingredient_page.dart';
import 'package:tech_task/presentation/screens/lunch_page.dart';
import 'package:tech_task/presentation/screens/recipe_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver{}

void main(){

  BuildContext context;

  final providers = [
    ChangeNotifierProvider<IngredientProvider>(create: (c) { context = c; return IngredientProvider(); }),
    ChangeNotifierProvider<RecipeProvider>(create: (c) { context = c; return RecipeProvider(); }),
  ];

  final Map<String, WidgetBuilder> routes = {
    LUNCH_PAGE_ROUTE : (_) => LunchPage(),
    INGREDIENT_PAGE_ROUTE: (_) => IngredientPage(),
    RECIPE_PAGE_ROUTE: (_) => RecipePage(),
  };
  
  Widget mockApp({Widget child, NavigatorObserver observer}) {
    return 
  
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Loadsmile Lunch App',
        theme: ThemeData(primarySwatch: PRIMARY_COLOR),
        routes: routes,
        navigatorObservers: [observer],
      ),
    );
  }

  LunchPage lunchPage;
  NavigatorObserver observer;

  setUp(() {
    lunchPage = LunchPage();
    observer = MockNavigatorObserver();
  });


  testWidgets('finding widgets in lunch page', (WidgetTester tester) async {
   
    await tester.pumpWidget(mockApp(child: lunchPage, observer: observer));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(InkResponse), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);

  });

  testWidgets("showing date picker dialog and choose date 15 on current monnth", (WidgetTester tester) async {

    await tester.pumpWidget(mockApp(child: lunchPage, observer: observer));

    await tester.tap(find.byIcon(Icons.date_range));
    await tester.pump();

    await tester.tap(find.text('15'));
    await tester.tap(find.text("OK"));

    DateTime mockDate = new DateTime(DateTime.now().year, DateTime.now().month, 15);
    expect(find.text(DateFormat(DATE_TIME_FORMAT).format(mockDate)), findsOneWidget);
    
  });

  testWidgets("entry invalid date and showing warning dialog", (WidgetTester tester) async {

    await tester.pumpWidget(mockApp(child: lunchPage, observer: observer));

    await tester.enterText(find.byType(TextField), "1234");
    await tester.tap(find.byType(RaisedButton));

    await tester.pump();

    expect(find.text(INVALID_DATE_MESSAGE), findsOneWidget);
    
  });

  testWidgets("tapping submit button and navigate to Ingredient Page", (WidgetTester tester) async {
     
     await tester.pumpWidget(mockApp(child: lunchPage, observer: observer));
     
     verify(observer.didPush(any, any));
     await tester.tap(find.byType(RaisedButton));

     verify(observer.didPush(any, any));
     await tester.pump();
     await tester.pump(const Duration(seconds: 3));
     expect(find.byType(IngredientPage), findsOneWidget);
  });

}

