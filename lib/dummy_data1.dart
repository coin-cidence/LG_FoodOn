import 'package:cloud_firestore/cloud_firestore.dart';

class DummyData {

  static List<Map<String, dynamic>> getFoodManagementData() {
    return [
      {
        "smart_shelf_serial": "SSS123456",
        "food_management_serial": 9,
        "food_name": "바나나",
        "food_weight": 260,
        "food_location": [
          {"x": 9, "y": 0},{"x": 9, "y": 1},{"x": 9, "y": 2},
          {"x": 10, "y": 0},{"x": 10, "y": 1},{"x": 10, "y": 2},
          {"x": 11, "y": 0},{"x": 11, "y": 1},{"x": 11, "y": 2},{"x": 11, "y": 3},
        ],
        "food_register_date": Timestamp.fromDate(DateTime(2024, 11, 29, 15, 30, 0)),
        "food_expiration_date": null,
        "food_expir_notif": false,
        "food_unused_notif_period": "1주일",
        "food_unused_notif": true,
        "food_weight_update_time": Timestamp.fromDate(DateTime(2024, 11, 29, 15, 30, 0)),
      },
      {
        "smart_shelf_serial": "SSS123456",
        "food_management_serial": 10,
        "food_name": "양송이",
        "food_weight": 100,
        "food_location": [
          {"x": 13, "y": 0},{"x": 13, "y": 1},
          {"x": 14, "y": 0},{"x": 14, "y": 1},
          {"x": 15, "y": 0},{"x": 15, "y": 1},
          {"x": 16, "y": 0},{"x": 16, "y": 1},
        ],
        "food_register_date": Timestamp.fromDate(DateTime(2024, 11, 30, 15, 30, 0)),
        "food_expiration_date": null,
        "food_expir_notif": false,
        "food_unused_notif_period": "1주일",
        "food_unused_notif": true,
        "food_weight_update_time": Timestamp.fromDate(DateTime(2024, 11, 30, 15, 30, 0)),
      },
    ];
  }

  static List<Map<String, dynamic>> getFoodManagementLogData() {
    return [
      {
        "food_management_log_no": 2,
        "food_management_serial": 9,
        "smart_shelf_serial": "SSS123456",
        "food_weight": 260,
        "food_location": [
          {"x": 9, "y": 0},{"x": 9, "y": 1},{"x": 9, "y": 2},{"x": 9, "y": 3},
          {"x": 10, "y": 0},{"x": 10, "y": 1},{"x": 10, "y": 2},{"x": 10, "y": 3},
          {"x": 11, "y": 0},{"x": 11, "y": 1},{"x": 11, "y": 2},{"x": 11, "y": 3},{"x": 11, "y": 4},
        ],
        "food_expiration_date": null,
        "food_is_delete": true,
        "food_expir_notif": false,
        "food_unused_notif_period": "1주일",
        "food_unused_notif": true,
        "event_datetime": Timestamp.fromDate(DateTime(2024, 11, 29, 15, 30, 0)),

      },
      {
        "food_management_log_no": 3,
        "food_management_serial": 10,
        "smart_shelf_serial": "SSS123456",
        "food_weight": 100,
        "food_location": [
          {"x": 13, "y": 0},{"x": 13, "y": 1},
          {"x": 14, "y": 0},{"x": 14, "y": 1},
          {"x": 15, "y": 0},{"x": 15, "y": 1},
          {"x": 16, "y": 0},{"x": 16, "y": 1},
        ],
        "food_expiration_date": null,
        "food_is_delete": true,
        "food_expir_notif": false,
        "food_unused_notif_period": "1주일",
        "food_unused_notif": true,
        "event_datetime": Timestamp.fromDate(DateTime(2024, 11, 30, 15, 30, 0)),

      },
    ];
  }
}

