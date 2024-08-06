import '/color.dart';
import '/models/vendor_model.dart';
import '/providers/business_overview_provider.dart';
import '/widgets/yearly_revenue_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../models/revenue_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _loadingsta = false;
  DateTime _selectedDate = DateTime.now();
  String _selectedYear = '2023';
  List<charts.Series<Revenue, String>> _chartData = [];

  @override
  void initState() {
    super.initState();
    fetchDataForYear(_selectedYear);
    fetchStatistics();
    fetchCompanies();
  }

  Future<void> fetchStatistics() async {
    try {
      setState(() {
        _loadingsta = true;
      });

      String dateToFetch;

      // Format the date as 'YYYY-MM-DD'
      dateToFetch =
          "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
      print(dateToFetch);
      await Provider.of<BusinessOverviewPro>(context, listen: false)
          .getStatistics('DailyStatistics', dateToFetch);

      setState(() {
        _loadingsta = false;
      });
    } catch (error) {
      setState(() {
        _loadingsta = false;
      });
      print(error);
    }
  }

  Future<void> fetchDataForYear(String year) async {
    try {
      setState(() {
        _loadingsta = true;
      });
      await Provider.of<BusinessOverviewPro>(context, listen: false)
          .dataForYear(year);

      setState(() {
        _loadingsta = false;
      });
    } catch (error) {
      setState(() {
        _loadingsta = false;
      });
      print(error);
    }
  }

  Future<void> fetchCompanies() async {
    try {
      setState(() {
        _loadingsta = true;
      });
      await Provider.of<BusinessOverviewPro>(context, listen: false)
          .companiesRequests();

      setState(() {
        _loadingsta = false;
      });
    } catch (error) {
      setState(() {
        _loadingsta = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loadedStatistics =
        Provider.of<BusinessOverviewPro>(context).statistics;
    final companies =
        Provider.of<BusinessOverviewPro>(context).getCompaniesRequests;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContainer(
                height: size.height * 0.2,
                width: size.width / 5.8,
                containerColor: const Color.fromRGBO(156, 100, 156, 0.68),
                title: 'Customers',
                titleColor: primary,
                containerIcon: Icons.people,
                value: loadedStatistics['customers']!,
                isLoading: _loadingsta,
              ),
              _buildContainer(
                height: size.height * 0.2,
                width: size.width / 5.8,
                containerColor: secondary.withOpacity(0.6),
                title: 'Companies',
                titleColor: primary,
                containerIcon: Icons.corporate_fare,
                value: loadedStatistics['companies']!,
                isLoading: _loadingsta,
              ),
              _buildContainer(
                height: size.height * 0.2,
                width: size.width / 5.8,
                containerColor: onPrimary,
                title: 'Revenue',
                titleColor: white,
                containerIcon: Icons.attach_money_rounded,
                value: '${loadedStatistics['revenue']} \$',
                isLoading: _loadingsta,
              ),
              _buildContainer(
                height: size.height * 0.2,
                width: size.width / 5.8,
                containerColor: const Color.fromRGBO(195, 215, 231, 1),
                title: 'Events',
                titleColor: onPrimary,
                containerIcon: Icons.event_available,
                value: loadedStatistics['events']!,
                isLoading: _loadingsta,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height / 3,
                width: 780,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.5),
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: SizedBox(
                  height: size.height / 2.9,
                  width: 750,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Yearly Revenue',
                              style: TextStyle(
                                color: primary,
                                fontFamily: 'CENSCBK',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: DropdownButton<String>(
                              value: _selectedYear,
                              items:
                                  ['2022', '2023', '2024'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedYear = newValue!;
                                  fetchDataForYear(_selectedYear);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: YearlyRevenueChart(
                          _chartData,
                          animate: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height / 3,
                width: size.width / 5.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.5),
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: SizedBox(
                  height: size.height / 3,
                  width: size.width / 5.8,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary:
                            primary.withOpacity(0.8), // header background color
                        onPrimary: Colors.white, // header text color
                        onSurface: onPrimary, // default text color
                      ),
                      datePickerTheme: const DatePickerThemeData(
                        yearStyle: TextStyle(
                          color: primary,
                          fontFamily: 'CENSCBK',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        weekdayStyle: TextStyle(
                          color: secondary,
                          fontFamily: 'CENSCBK',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        dayStyle: TextStyle(
                          color: primary,
                          fontFamily: 'CENSCBK',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: CalendarDatePicker(
                      initialDate: _selectedDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2030),
                      onDateChanged: (newDate) {
                        setState(
                          () {
                            _selectedDate = newDate;
                          },
                        );
                        fetchStatistics();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: size.height / 3,
            width: size.width * 0.77,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.5),
                  offset: const Offset(
                    1.0,
                    1.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Expanded(
              child: _loadingsta
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        final request = companies[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(request.logoUrl),
                          ),
                          title: Text(request.companyName),
                          subtitle:
                              Text('${request.email}\n${request.phoneNumber}'),
                          isThreeLine: true,
                          onTap: () => _showDetailsDialog(request, context),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check,
                                    color: Colors.green),
                                onPressed: () {
                                  // Handle accept request
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  // Handle reject request
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

Container _buildContainer({
  required double height,
  required double width,
  required Color containerColor,
  required String title,
  required Color titleColor,
  required IconData containerIcon,
  required String value,
  required bool isLoading,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: containerColor,
      boxShadow: [
        const BoxShadow(
          color: white,
          offset: Offset(
            1.0,
            1.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontFamily: 'IrishGrover',
                fontSize: 18,
              ),
            ),
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(217, 217, 217, 0.4),
              child: Icon(
                containerIcon,
                color: white,
              ),
            ),
          ],
        ),
        isLoading
            ? const CircularProgressIndicator()
            : Text(
                value,
                style: const TextStyle(
                  color: white,
                  fontFamily: 'CENSCBK',
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    ),
  );
}

void _showDetailsDialog(Vendor request, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(request.companyName),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(
                  request.logoUrl,
                ),
              ),
              Row(
                children: [
                  Text('Name:'),
                  Text(' ${request.firstName} ${request.lastName}'),
                ],
              ),
              Row(
                children: [
                  Text('Email: '),
                  Text('${request.email}'),
                ],
              ),
              Row(
                children: [
                  Text('Phone:'),
                  Text(' ${request.phoneNumber}'),
                ],
              ),
              Row(
                children: [
                  Text('Registration Number:'),
                  Text(' ${request.registrationNumber}'),
                ],
              ),
              Row(
                children: [
                  Text('Location:'),
                  Text(' ${request.location}'),
                  Text('City:'),
                  Text(' ${request.city}'),
                  Text('Country:'),
                  Text(' ${request.country}'),
                ],
              ),
              Row(
                children: [
                  Text('Description:'),
                  Text(' ${request.description}'),
                ],
              ),
              Row(
                children: [
                  Text('Categories:'),
                  Text(' ${request.categoryIds.join(', ')}'),
                ],
              ),
              Row(
                children: [
                  Text('Event Types:'),
                  Text(' ${request.eventTypeIds.join(', ')}'),
                ],
              ),
              Text('Work Hours:'),
              // ...request.workHours.entries
              //     .map((entry) => Text('${entry.key}: ${entry.value}'))
              //     .toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
