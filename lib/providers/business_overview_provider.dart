import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:eventique_admin_dashboard/main.dart';
import 'package:eventique_admin_dashboard/models/revenue_model.dart';
import 'package:eventique_admin_dashboard/models/vendor_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BusinessOverviewPro with ChangeNotifier {
  final String token;
  BusinessOverviewPro(this.token);
  var _statistics = {
    'customers': '1507',
    'companies': '105',
    'revenue': '1040',
    'events': '2064'
  };
  List<charts.Series<Revenue, String>> _chartData = [];
  List<Vendor> _companyRequests = [
    Vendor(
      logoUrl: 'https://via.placeholder.com/50',
      companyName: 'Example Corp',
      email: 'contact@example.com',
      phoneNumber: '123-456-7890',
      firstName: 'John',
      lastName: 'Doe',
      registrationNumber: '123456789',
      location: '123 Business Rd',
      city: 'Metropolis',
      country: 'Countryland',
      description: 'A brief description of the company.',
      categoryIds: ['cake', 'decoration'],
      eventTypeIds: ['wedding'],
      workHours: [
        {
          'day': 'Monday',
          'hours_from': '09:00',
          'hours_to': '18:00',
        }
      ],
    ),
  ];
  List<Vendor> get getCompaniesRequests {
    return [..._companyRequests];
  }

  Map<String, String> get statistics {
    return {..._statistics};
  }

  Future<void> getStatistics(String route, String date) async {
    final url = Uri.parse('$host/api/admin/statistics/$route');
    print(url);
    print(date);
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'date': date,
        },
      );

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['Status'] == 'Failed') {
        throw Exception(responseData['Error']);
      }
      _statistics['customers'] = responseData['user_count'].toString();
      _statistics['companies'] = responseData['service_count'].toString();
      _statistics['revenue'] = responseData['total_profit'].toString();
      _statistics['events'] = responseData['avg_rating'] == null
          ? 'No rating'
          : responseData['avg_rating'].toString();
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> companiesRequests() async {
    final url = Uri.parse('$host/api/company/statistics/');
    print(url);

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['Status'] == 'Failed') {
        throw Exception(responseData['Error']);
      }

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> dataForYear(String year) async {
    final url = Uri.parse('$host/api/company/statistics/');
    print(url);

    try {
      final response = await http.post(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final responseData = json.decode(response.body);
      print(responseData);

      if (responseData['Status'] == 'Failed') {
        throw Exception(responseData['Error']);
      }

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
