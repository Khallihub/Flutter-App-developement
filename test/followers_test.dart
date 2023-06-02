import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picstash/presentation/components/user_followers.dart';
import 'package:picstash/presentation/screens/followers.dart';
import 'package:picstash/domain/entities/user_profile/user_profile.dart';

void main() {
  testWidgets('ShowFollowers displays list of followers',
      (WidgetTester tester) async {
    // Create a list of sample UserProfile objects
    final userFollowers = [
      UserProfile(
          id: '1',
          name: 'amir',
          email: 'shuabahmedin@gmail.com',
          userName: 'amir',
          avatar: 'avatar',
          bio: 'how r u doing',
          role: 'user'),
      UserProfile(
          id: '2',
          name: 'Amir',
          email: 'shuabahmedin@gmail.com',
          userName: 'amir',
          avatar: 'avatar',
          bio: 'how r u doing',
          role: 'user'),
    ];

    // Build the ShowFollowers widget with the sample data
    await tester.pumpWidget(
      const MaterialApp(
        home: ShowFollowers(),
      ),
    );

    // Verify that the UI displays the correct widgets
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Followers), findsNWidgets(userFollowers.length));
    expect(find.widgetWithText(Followers, 'Follower1'), findsOneWidget);
    expect(find.widgetWithText(Followers, 'Follower2'), findsOneWidget);
    expect(find.widgetWithText(Followers, 'Follower3'), findsOneWidget);
  });
}
