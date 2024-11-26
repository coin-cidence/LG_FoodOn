class DummyData {
  static Map<String, dynamic> getUserData() {
    return {
      "001": {
        "userName": "푸디온",
        "userAge": 45,
        "userCreateDate": DateTime(2024, 10, 15).toIso8601String(),
        "userUpdateDate": DateTime(2024, 10, 20, 15, 32, 1).toIso8601String(),
      }
    };
  }

  static Map<String, dynamic> getFridgeData() {
    return {
      "6879ZASD123456": {
        "fridgeModelName": "LG DIOS F850SN33",
        "fridgeRegDate": DateTime(2024, 10, 22).toIso8601String(),
      }
    };
  }

  static List<Map<String, dynamic>> getSmartShelvesData() {
    return [
      {
        "smartShelfSerial": "6879ZASD123456",
        "fridgeSerial": "6879ZASD123456",
        "shelfLocation": "선반1",
        "shelfRegDate": DateTime(2024, 10, 22).toIso8601String()
      },
      {
        "smartShelfSerial": "6879ZASD234567",
        "fridgeSerial": "6879ZASD123456",
        "shelfLocation": "선반2",
        "shelfRegDate": DateTime(2024, 10, 23).toIso8601String()
      },
      {
        "smartShelfSerial": "6879ZASD345678",
        "fridgeSerial": "6879ZASD123456",
        "shelfLocation": "선반3",
        "shelfRegDate": DateTime(2024, 10, 24).toIso8601String()
      },
      {
        "smartShelfSerial": "6879ZASD456789",
        "fridgeSerial": "6879ZASD123456",
        "shelfLocation": "선반4",
        "shelfRegDate": DateTime(2024, 10, 25).toIso8601String()
      },
    ];
  }

  static List<Map<String, dynamic>> getFoodManagementData() {
    return [
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "가지",
        "foodWeight": 300,
        "foodLocation": [
          {"x": 0, "y": 1}, {"x": 0, "y": 2}, {"x": 0, "y": 3},
          {"x": 1, "y": 0}, {"x": 1, "y": 1}, {"x": 1, "y": 2}, {"x": 1, "y": 3},
          {"x": 2, "y": 0}, {"x": 2, "y": 1}, {"x": 2, "y": 2},
        ],
        "foodRegisterDate": DateTime(2024, 11, 01, 15, 30, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 5,
        "foodIsNotif": true,
        "foodWeightUpdateTime": DateTime(2024, 11, 01, 12, 0, 0).toIso8601String(),
      },
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "감",
        "foodWeight": 200,
        "foodLocation": [
          {"x": 3, "y": 8}, {"x": 3, "y": 9}, {"x": 3, "y": 10}, {"x": 3, "y": 11},
          {"x": 4, "y": 8}, {"x": 4, "y": 9}, {"x": 4, "y": 10}, {"x": 4, "y": 11},
          {"x": 5, "y": 8}, {"x": 5, "y": 9}, {"x": 5, "y": 10}, {"x": 5, "y": 11},
          {"x": 6, "y": 8}, {"x": 6, "y": 9}, {"x": 6, "y": 10}, {"x": 6, "y": 11},
        ],
        "foodRegisterDate": DateTime(2024, 11, 25, 11, 0, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 7,
        "foodIsNotif": false,
        "foodWeightUpdateTime": DateTime(2024, 11, 25, 14, 0, 0).toIso8601String(),
      },
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "방울토마토",
        "foodWeight": 500,
        "foodLocation": [
          {"x": 4, "y": 0}, {"x": 4, "y": 1}, {"x": 4, "y": 2},
          {"x": 5, "y": 0}, {"x": 5, "y": 1}, {"x": 5, "y": 2},
          {"x": 6, "y": 0}, {"x": 6, "y": 1}, {"x": 6, "y": 2},
          {"x": 7, "y": 0}, {"x": 7, "y": 1}, {"x": 7, "y": 2},
        ],
        "foodRegisterDate": DateTime(2024, 11, 25, 9, 0, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 3,
        "foodIsNotif": true,
        "foodWeightUpdateTime": DateTime(2024, 11, 25, 10, 0, 0).toIso8601String(),
      },
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "사과",
        "foodWeight": 400,
        "foodLocation": [
          {"x": 0, "y": 5}, {"x": 0, "y": 6}, {"x": 0, "y": 7}, {"x": 0, "y": 8},
          {"x": 1, "y": 5}, {"x": 1, "y": 6}, {"x": 1, "y": 7}, {"x": 1, "y": 8},
          {"x": 2, "y": 5}, {"x": 2, "y": 6}, {"x": 2, "y": 7}, {"x": 2, "y": 8},
        ],
        "foodRegisterDate": DateTime(2024, 11, 1, 16, 0, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 10,
        "foodIsNotif": false,
        "foodWeightUpdateTime": DateTime(2024, 11, 1, 18, 0, 0).toIso8601String(),
      },
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "고구마",
        "foodWeight": 0,
        "foodLocation": [
          {"x": 9, "y": 8}, {"x": 9, "y": 9}, {"x": 9, "y": 10}, {"x": 9, "y": 11},
          {"x": 10, "y": 8}, {"x": 10, "y": 9}, {"x": 10, "y": 10}, {"x": 10, "y": 11},
          {"x": 11, "y": 8}, {"x": 11, "y": 9}, {"x": 11, "y": 10}, {"x": 11, "y": 11},
        ],
        "foodRegisterDate": DateTime(2024, 11, 26, 12, 0, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 6,
        "foodIsNotif": true,
        "foodWeightUpdateTime": DateTime(2024, 11, 26, 9, 0, 0).toIso8601String(),
      },
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "배추",
        "foodWeight": 1200,
        "foodLocation": [
          {"x": 7, "y": 5}, {"x": 7, "y": 6}, {"x": 7, "y": 7},
          {"x": 8, "y": 5}, {"x": 8, "y": 6}, {"x": 8, "y": 7},
          {"x": 9, "y": 4}, {"x": 9, "y": 5}, {"x": 9, "y": 6}, {"x": 9, "y": 7},
          {"x": 10, "y": 4}, {"x": 10, "y": 5}, {"x": 10, "y": 6},
        ],
        "foodRegisterDate": DateTime(2024, 11, 15, 11, 0, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 10,
        "foodIsNotif": true,
        "foodWeightUpdateTime": DateTime(2024, 11, 16, 8, 0, 0).toIso8601String(),
      },
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "오이",
        "foodWeight": 0,
        "foodLocation": [
          {"x": 14, "y": 0}, {"x": 14, "y": 1}, {"x": 14, "y": 2}, {"x": 14, "y": 3},
          {"x": 15, "y": 0}, {"x": 15, "y": 1}, {"x": 15, "y": 2}, {"x": 15, "y": 3},
        ],
        "foodRegisterDate": DateTime(2024, 11, 10, 11, 0, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 20,
        "foodIsNotif": true,
        "foodWeightUpdateTime": DateTime(2024, 11, 11, 8, 0, 0).toIso8601String(),
      },
      {
        "smartShelfSerial": "6879ZASD123456",
        "foodName": "당근",
        "foodWeight": 0,
        "foodLocation": [
          {"x": 14, "y": 5}, {"x": 14, "y": 6}, {"x": 14, "y": 7}, {"x": 14, "y": 8},
          {"x": 15, "y": 5}, {"x": 15, "y": 6}, {"x": 15, "y": 7}, {"x": 15, "y": 8},
        ],
        "foodRegisterDate": DateTime(2024, 11, 15, 13, 0, 0).toIso8601String(),
        "foodExpirationDate": null,
        "foodUnusedNotifPeriod": 60,
        "foodIsNotif": true,
        "foodWeightUpdateTime": DateTime(2024, 11, 16, 9, 0, 0).toIso8601String(),
      },
    ];
  }

  static Map<String, dynamic> getFoodManagementLogData() {
    return {
      "log_001": {
        "foodManagementSerial": "food_001",
        "smartShelfSerial": "6879ZASD123456",
        "foodWeight": 400,
        "foodLocation": [
          {"x": 0, "y": 1}, {"x": 0, "y": 2}, {"x": 0, "y": 3},
          {"x": 1, "y": 0}, {"x": 1, "y": 1}, {"x": 1, "y": 2}, {"x": 1, "y": 3},
          {"x": 2, "y": 0}, {"x": 2, "y": 1}, {"x": 2, "y": 2},
        ],
        "foodExpirationDate": null,
        "foodIsDelete": true,
        "foodUnusedNotifPeriod": 5,
        "eventDatetime": DateTime(2024, 11, 01, 12, 0, 0).toIso8601String(),
      },
    };
  }
}
