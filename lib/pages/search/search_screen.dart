import 'package:betweener_app/controllers/api/follow_api_controller.dart';
import 'package:betweener_app/controllers/api/search_api_controller.dart';
import 'package:betweener_app/core/helper/snak_bar.dart';
import 'package:betweener_app/core/util/constants.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/models/follow.dart';
import 'package:betweener_app/pages/widgets/custom_text_form_field.dart';
import 'package:betweener_app/pages/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../widgets/follow_btn.dart';

class SearchScreen extends StatefulWidget {
  static String id = '/search_screen';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with Helper {
  final _keyForm = GlobalKey<FormState>();
  late TextEditingController _searchCtr;
  List<User> listOfUser = [];
  late Follow follow;

  Future<void> submitSearch() async {
    if (_keyForm.currentState!.validate()) {
      listOfUser = await SearchApiController().searchName(_searchCtr.text);
      setState(() {});
    }
  }

  void getFollow() async {
    follow = await FollowApiController().getFollow();
    setState(() {});
  }

  @override
  void initState() {
    getFollow();
    // TODO: implement initState
    super.initState();
    _searchCtr = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              CustomTextFormField(
                // onChanged: (v) {
                //   submitSearch(v);
                // },
                controller: _searchCtr,
                hintText: 'Search by user name ',
                labelText: 'Search',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SecondaryButtonWidget(
                title: 'Search',
                width: 150,
                onTap: submitSearch,
              ),
              const SizedBox(
                height: 20,
              ),
              listOfUser.isEmpty? const SizedBox(
                height: 200,
                child: Center(
                    child: Text(
                      ' Name is not found',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
              ):Expanded(
                  child:  ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: listOfUser.length,
                itemBuilder: (context, index) {
                  return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: kLightPrimaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(listOfUser[index].name!),
                              FollowBtn(
                                isFollow: follow.following!.where((element) {
                                  return element.id == listOfUser[index].id;
                                }).isNotEmpty
                                    ? true
                                    : false,
                                followFunction: () async {
                                  ApiHelper apiResponse =
                                      await FollowApiController().addFollow({
                                    'followee_id':
                                        listOfUser[index].id.toString()
                                  });
                                  getFollow();

                                  snackBar(context,
                                      message: apiResponse.message,
                                      success: apiResponse.success);
                                },
                                unFollowFunction: () {
                                  print('ahmed');
                                },
                              )
                            ],
                          ));
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
