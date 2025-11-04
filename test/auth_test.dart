import 'package:flutter_test/flutter_test.dart';
import 'package:astrology_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('UserModel', () {
    test('should create UserModel from map', () {
      final map = {
        'email': 'test@example.com',
        'displayName': 'Test User',
        'role': 'end_user',
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'isActive': true,
      };

      final user = UserModel.fromMap(map, 'test-id');

      expect(user.id, 'test-id');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
      expect(user.role, 'end_user');
      expect(user.isActive, true);
    });

    test('should convert UserModel to map', () {
      final user = UserModel(
        id: 'test-id',
        email: 'test@example.com',
        displayName: 'Test User',
        role: 'end_user',
        createdAt: DateTime.now(),
      );

      final map = user.toMap();

      expect(map['email'], 'test@example.com');
      expect(map['displayName'], 'Test User');
      expect(map['role'], 'end_user');
    });

    test('should create copy with updated fields', () {
      final user = UserModel(
        id: 'test-id',
        email: 'test@example.com',
        displayName: 'Test User',
        role: 'end_user',
        createdAt: DateTime.now(),
      );

      final updated = user.copyWith(displayName: 'Updated Name');

      expect(updated.id, user.id);
      expect(updated.email, user.email);
      expect(updated.displayName, 'Updated Name');
      expect(updated.role, user.role);
    });
  });
}

