import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventique_admin_dashboard/color.dart';
import 'package:eventique_admin_dashboard/models/one_service.dart';
import 'package:eventique_admin_dashboard/providers/packages.dart';
import 'package:eventique_admin_dashboard/screens/service_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageDetailsScreen extends StatelessWidget {
  final List<OneService> services;
  final double oldPrice;
  final double newPrice;
  final int packageId;

  PackageDetailsScreen({
    super.key,
    required this.services,
    required this.newPrice,
    required this.oldPrice,
    required this.packageId,
  });

  // Future<void> _deleteService(BuildContext context, int serviceId) async {
  //   // Show a loading indicator while deleting
  //   final loadingDialog = showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent closing the dialog by tapping outside
  //     builder: (ctx) => Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );

  //   try {
  //     // Call the provider to delete the service
  //     await Provider.of<Packages>(context, listen: false).deleteService(packageId, serviceId);
      
  //     // Remove the service from the local list
  //     services.removeWhere((element) => element.serviceId == serviceId);

  //     // Close the loading indicator
  //     Navigator.of(context).pop(); // Dismiss the CircularProgressIndicator

  //     // Optionally show a confirmation snack bar
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Service deleted successfully')),
  //     );
  //   } catch (error) {
  //     // Dismiss the loading indicator
  //     Navigator.of(context).pop(); 

  //     // Handle error (e.g., show a snackbar or dialog)
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error deleting service')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 2.4;
    final double itemWidth = size.width / 7.5;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Column(
            children: [
              Container(
                height: size.height * 0.4,
                color: secondary.withOpacity(0.6),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Foreground Container
          Positioned(
            top: size.height * 0.15,
            left: 20,
            right: 20,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              height: size.height * 0.7,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12.0,
                    offset: Offset(0, 0),
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Package Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CENSCBK',
                        color: primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Old price $oldPrice , New price is $newPrice',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CENSCBK',
                        color: primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 46),
                  // Horizontal ListView
                  Container(
                    height: itemHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: itemWidth,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 12.0,
                                spreadRadius: 1.0,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    width: size.width * 0.3,
                                    padding: EdgeInsets.all(16),
                                    child: ServiceDetails(
                                      name: services[index].name,
                                      vendorName: services[index].vendorName,
                                      description: services[index].description,
                                      imgsUrls: services[index].imgsUrl,
                                      price: services[index].price,
                                    ),
                                  ),
                                ),
                              );
                            },
                            // onDoubleTap: () async {
                            //   // final shouldDelete = await showDialog<bool>(
                            //   //   context: context,
                            //   //   builder: (ctx) => AlertDialog(
                            //   //     title: Text('Confirm Deletion'),
                            //   //     content: Text('Delete service from package?'),
                            //   //     actions: <Widget>[
                            //   //       TextButton(
                            //   //         child: Text('No'),
                            //   //         onPressed: () {
                            //   //           Navigator.of(ctx).pop(false);
                            //   //         },
                            //   //       ),
                            //   //       TextButton(
                            //   //         child: Text('Yes'),
                            //   //         onPressed: () {
                            //   //           Navigator.of(ctx).pop(true);
                            //   //         },
                            //   //       ),
                            //   //     ],
                            //   //   ),
                            //   // );

                            //   // if (shouldDelete == true) {
                            //   //   await _deleteService(context, services[index].serviceId);
                            //   // }
                            // },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      height: itemHeight * 0.6,
                                      width: itemWidth * 0.7,
                                      child: CachedNetworkImage(
                                        imageUrl: services[index].imgsUrl[0] ?? '',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: const Color.fromARGB(255, 242, 242, 242),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: const Color.fromARGB(255, 242, 242, 242),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  services[index].name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'CENSCBK',
                                    color: primary,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  services[index].vendorName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: primary,
                                    fontFamily: 'CENSCBK',
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
