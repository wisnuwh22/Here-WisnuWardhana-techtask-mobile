import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/screens/lunch_page.dart';
import 'package:tech_task/settings/constants.dart';
import 'package:tech_task/settings/messages.dart';

void main(){
  
  Widget mockApp({Widget child, NavigatorObserver observer}) {
    return MaterialApp(
        home: child
      );
  }

  LunchPage lunchPage;
  NavigatorObserver observer;

  setUp(() {
    lunchPage = LunchPage();
  });

  setUpAll((){
    
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
    expect(find.text(DateFormat(dateTimeFormat).format(mockDate)), findsOneWidget);
    
  });

  testWidgets("entry invalid date and showing warning dialog", (WidgetTester tester) async {

    await tester.pumpWidget(mockApp(child: lunchPage, observer: observer));

    await tester.enterText(find.byType(TextField), "1234");
    await tester.tap(find.byType(RaisedButton));

    await tester.pump();

    expect(find.text(invalidLunchDateMessage), findsOneWidget);
    
  });

}

