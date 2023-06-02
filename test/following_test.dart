import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picstash/domain/entities/user_profile/models.dart';
import 'package:picstash/presentation/components/user_following.dart';
import 'package:picstash/presentation/screens/following.dart';

void main() {
  testWidgets('ShowFollowings displays correct number of user followings',
      (WidgetTester tester) async {
    // Create a list of user followings
    final userFollowings = [
      UserProfile(
          userName: 'John Doe',
          avatar: '',
          bio: '',
          email: '',
          id: '',
          name: '',
          role: ''),
      UserProfile(
          userName: 'Jane Doe',
          avatar: '',
          bio: '',
          email: '',
          id: '',
          name: '',
          role: ''),
      UserProfile(
          userName: 'Bob Smith',
          avatar: '',
          bio: '',
          email: '',
          id: '',
          name: '',
          role: ''),
    ];

    // Build the ShowFollowings widget with the list of user followings
    await tester.pumpWidget(
      const MaterialApp(
        home: ShowFollowings(),
      ),
    );

    // Verify that the correct number of user followings are displayed
    expect(find.byType(Following), findsNWidgets(3));
  });
}
