import 'package:betweener_app/controllers/api/user_controller.dart';
import 'package:betweener_app/core/helper/api_response.dart';
import 'package:betweener_app/core/util/constants.dart';
import 'package:betweener_app/provider/link_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/api/links_api_controller.dart';
import '../../models/user.dart';
import '../link/add_link_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,() {
      Provider.of<LinkProvider>(context, listen: false).fetchLink(context);

    },);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<UserAuth>(
              future: getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Welcome ${snapshot.data!.user!.name}',
                    style: GoogleFonts.roboto(
                        color: kPrimaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  );
                } else {
                  return const Center(
                    child: Text('No Data'),
                  );
                }
              },
            ),
            Center(
              child: Image.asset(
                qrImage,
                width: 250,
                height: 341.58,
              ),
            ),
            const Divider(
              indent: 50,
              endIndent: 50,
              height: 1,
              thickness: 2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<LinkProvider>(
              builder: (_, linkProvider, __) {
                if (linkProvider.links.status == Status.LOADING) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }  if (linkProvider.links.status == Status.COMPLETED) {
                  return SizedBox(
                    height: 100,
                    child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == linkProvider.links.data!.length) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AddLinkScreen.id)
                                      .then((_) {
                                    setState(() {
                                      linkProvider.fetchLink(context);
                                    });
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffE7E5F1),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(children: [
                                      Text(
                                        '+',
                                        style: GoogleFonts.roboto(
                                            color: kPrimaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Add More',
                                        style: GoogleFonts.roboto(
                                            color: kPrimaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ])));
                          }  if (index < linkProvider.links.data!.length) {
                            return Container(
                              width: 110,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' ${linkProvider.links.data?[index].title}',
                                    style: GoogleFonts.roboto(
                                        color: kOnSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    linkProvider.links.data![index].link!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        color: kOnSecondaryColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 12,
                          );
                        },
                        itemCount: linkProvider.links.data!.length + 1),
                  );
                }  if (linkProvider.links.status == Status.ERROR) {
                  return Center(
                    child: Text('${linkProvider.links.message}'),
                  );
                } else {
                  return const Center(
                    child: Text('No data'),
                  );
                }
              },
            ),
            // FutureBuilder<List<Links>>(
            //   future: LinksApiController().getLinks(context),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (snapshot.hasData) {
            //       return SizedBox(
            //         height: 100,
            //         child: ListView.separated(
            //             padding: const EdgeInsets.all(12),
            //             scrollDirection: Axis.horizontal,
            //             itemBuilder: (context, index) {
            //               if (index == snapshot.data!.length) {
            //                 return GestureDetector(
            //                     onTap: () {
            //                       Navigator.pushNamed(context, AddLinkScreen.id)
            //                           .then((_) {
            //                         final link =
            //                             LinksApiController().getLinks(context);
            //                         setState(() {
            //                           link;
            //                         });
            //                       });
            //                     },
            //                     child: Container(
            //                         padding: const EdgeInsets.all(12),
            //                         decoration: BoxDecoration(
            //                             color: const Color(0xffE7E5F1),
            //                             borderRadius:
            //                                 BorderRadius.circular(12)),
            //                         child: Column(children: [
            //                           Text(
            //                             '+',
            //                             style: GoogleFonts.roboto(
            //                                 color: kPrimaryColor,
            //                                 fontSize: 20,
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                           Text(
            //                             'Add More',
            //                             style: GoogleFonts.roboto(
            //                                 color: kPrimaryColor,
            //                                 fontSize: 16,
            //                                 fontWeight: FontWeight.w600),
            //                           ),
            //                         ])));
            //               }
            //
            //               if (index < snapshot.data!.length) {
            //                 return Container(
            //                   width: 110,
            //                   padding: const EdgeInsets.all(12),
            //                   decoration: BoxDecoration(
            //                       color: kSecondaryColor,
            //                       borderRadius: BorderRadius.circular(12)),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         snapshot.data![index].title!,
            //                         style: GoogleFonts.roboto(
            //                             color: kOnSecondaryColor,
            //                             fontWeight: FontWeight.w600,
            //                             fontSize: 16),
            //                       ),
            //                       Text(
            //                         snapshot.data![index].link!,textAlign: TextAlign.center,
            //                         style: GoogleFonts.roboto(
            //                             color: kOnSecondaryColor,
            //                             fontWeight: FontWeight.w300,
            //                             fontSize: 10),
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               }
            //             },
            //             separatorBuilder: (context, index) {
            //               return const SizedBox(
            //                 width: 12,
            //               );
            //             },
            //             itemCount: snapshot.data!.length + 1),
            //       );
            //     } else {
            //       return const Center(
            //         child: Text('No data'),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

// Consumer<LinkProvider>(builder: (context, value, child) {
//   if (value.loading) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   } else if (value.link.isNotEmpty) {
//     return SizedBox(
//       height: 100,
//       child: ListView.separated(
//           padding: const EdgeInsets.all(12),
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             if (index == value.link.length) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, AddLinkScreen.id)
//                       .then((_) {
//                     final link =
//                         LinksApiController().getLinks(context);
//                     setState(() {
//                       link;
//                     });
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                       color: const Color(0xffE7E5F1),
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Column(
//                     children: [
//                       Text(
//                         '+',
//                         style: GoogleFonts.roboto(
//                             color: kPrimaryColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         'Add More',
//                         style: GoogleFonts.roboto(
//                             color: kPrimaryColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//
//             if (index < value.link.length) {
//               return Container(
//                 width: 100,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                     color: kSecondaryColor,
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Column(
//                   children: [
//                     Text(
//                       value.link[index].title!,
//                       style: GoogleFonts.roboto(fontWeight: FontWeight.w600,
//                           color: kOnSecondaryColor, fontSize: 16),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       value.link[index].link!,
//                       style: GoogleFonts.roboto(
//                           color:
//                                kOnSecondaryColor
//                               ,
//                           fontSize: 13,fontWeight: FontWeight.w300),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//           separatorBuilder: (context, index) {
//             return const SizedBox(
//               width: 8,
//             );
//           },
//           itemCount: value.link.length + 1),
//     );
//   } else {
//     return const Center(
//       child: Text('No data'),
//     );
//   }
// }),
