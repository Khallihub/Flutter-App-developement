import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/domain/entities/user_profile/user_profile.dart';
import 'package:picstash/presentation/screens/chat_list_screen.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import 'package:picstash/presentation/screens/home_screen.dart';
import 'package:picstash/presentation/screens/post_adding.dart';
import 'package:picstash/presentation/screens/post_screen.dart';
import 'package:picstash/presentation/screens/user_profile_screen.dart';

class MockUserProfile extends Mock implements UserProfile {}

void main() {
  group('Home', () {
    testWidgets('should display PostScreen initially', (tester) async {
      final mockUserProfile = MockUserProfile();
      when(mockUserProfile.id).thenReturn('1');
      when(mockUserProfile.name).thenReturn('John Doe');
      when(mockUserProfile.email).thenReturn('john.doe@example.com');
      when(mockUserProfile.userName).thenReturn('johndoe');
      when(mockUserProfile.avatar).thenReturn('http://example.com/avatar.jpg');
      when(mockUserProfile.bio).thenReturn('I am a software engineer');
      when(mockUserProfile.role).thenReturn('user');

      await tester.pumpWidget(const MaterialApp(home: Home()));

      expect(find.byType(PostScreen), findsOneWidget);
      expect(find.byType(ErrorPage), findsNothing);
      expect(find.byType(AddPostWidget), findsNothing);
      expect(find.byType(ChatListScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsNothing);
    });

    testWidgets('should display ErrorPage after tapping second tab',
        (tester) async {
      final mockUserProfile = MockUserProfile();
      when(mockUserProfile.id).thenReturn('1');
      when(mockUserProfile.name).thenReturn('John Doe');
      when(mockUserProfile.email).thenReturn('john.doe@example.com');
      when(mockUserProfile.userName).thenReturn('johndoe');
      when(mockUserProfile.avatar).thenReturn('http://example.com/avatar.jpg');
      when(mockUserProfile.bio).thenReturn('I am a software engineer');
      when(mockUserProfile.role).thenReturn('user');

      await tester.pumpWidget(const MaterialApp(home: Home()));

      final secondTab = find.byIcon(Icons.search);
      expect(secondTab, findsOneWidget);

      await tester.tap(secondTab);
      await tester.pumpAndSettle();

      expect(find.byType(PostScreen), findsNothing);
      expect(find.byType(ErrorPage), findsOneWidget);
      expect(find.byType(AddPostWidget), findsNothing);
      expect(find.byType(ChatListScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsNothing);
    });

    testWidgets('should display AddPostWidget after tapping third tab',
        (tester) async {
      final mockUserProfile = MockUserProfile();
      when(mockUserProfile.id).thenReturn('1');
      when(mockUserProfile.name).thenReturn('John Doe');
      when(mockUserProfile.email).thenReturn('john.doe@example.com');
      when(mockUserProfile.userName).thenReturn('johndoe');
      when(mockUserProfile.avatar).thenReturn('http://example.com/avatar.jpg');
      when(mockUserProfile.bio).thenReturn('I am a software engineer');
      when(mockUserProfile.role).thenReturn('user');

      await tester.pumpWidget(MaterialApp(home: Home()));

      final thirdTab = find.byIcon(Icons.add);
      expect(thirdTab, findsOneWidget);

      await tester.tap(thirdTab);
      await tester.pumpAndSettle();

      expect(find.byType(PostScreen), findsNothing);
      expect(find.byType(ErrorPage), findsNothing);
      expect(find.byType(AddPostWidget), findsOneWidget);
      expect(find.byType(ChatListScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsNothing);
    });

    testWidgets('should display ChatListScreen after tapping fourth tab',
        (tester) async {
      final mockUserProfile = MockUserProfile();
      when(mockUserProfile.id).thenReturn('1');
      when(mockUserProfile.name).thenReturn('John Doe');
      when(mockUserProfile.email).thenReturn('john.doe@example.com');
      when(mockUserProfile.userName).thenReturn('johndoe');
      when(mockUserProfile.avatar).thenReturn('http://example.com/avatar.jpg');
      when(mockUserProfile.bio).thenReturn('I am a software engineer');
      when(mockUserProfile.role).thenReturn('user');

      await tester.pumpWidget(MaterialApp(home: Home()));

      final fourthTab = find.byIcon(Icons.chat);
      expect(fourthTab, findsOneWidget);

      await tester.tap(fourthTab);
      await tester.pumpAndSettle();

      expect(find.byType(PostScreen), findsNothing);
      expect(find.byType(ErrorPage), findsNothing);
      expect(find.byType(AddPostWidget), findsNothing);
      expect(find.byType(ChatListScreen), findsOneWidget);
      expect(find.byType(UserProfileScreen), findsNothing);
    });

    testWidgets('should display UserProfileScreen after tapping fifth tab',
        (tester) async {
      final mockUserProfile = MockUserProfile();
      when(mockUserProfile.id).thenReturn('1');
      when(mockUserProfile.name).thenReturn('John Doe');
      when(mockUserProfile.email).thenReturn('john.doe@example.com');
      when(mockUserProfile.userName).thenReturn('johndoe');
      when(mockUserProfile.avatar).thenReturn('http://example.com/avatar.jpg');
      when(mockUserProfile.bio).thenReturn('I am a software engineer');
      when(mockUserProfile.role).thenReturn('user');

      await tester.pumpWidget(MaterialApp(home: Home()));

      final fifthTab = find.byIcon(Icons.person);
      expect(fifthTab, findsOneWidget);

      await tester.tap(fifthTab);
      await tester.pumpAndSettle();

      expect(find.byType(PostScreen), findsNothing);
      expect(find.byType(ErrorPage), findsNothing);
      expect(find.byType(AddPostWidget), findsNothing);
      expect(find.byType(ChatListScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsOneWidget);
    });
  });
}
