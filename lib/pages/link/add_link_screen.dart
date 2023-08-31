import 'package:betweener_app/controllers/api/links_api_controller.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/pages/widgets/custom_text_form_field.dart';
import 'package:betweener_app/pages/widgets/secondary_button_widget.dart';
import 'package:betweener_app/provider/link_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/helper/snak_bar.dart';

class AddLinkScreen extends StatefulWidget {
  static String id = '/add_link_screen';

  const AddLinkScreen({super.key});

  @override
  State<AddLinkScreen> createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> with Helper {
  late TextEditingController _titleCtl ;
  late TextEditingController _linkCtl ;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _titleCtl = TextEditingController();
    _linkCtl = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _titleCtl.dispose();
    _linkCtl.dispose();
    super.dispose();
  }
  final _keyForm = GlobalKey<FormState>();
 void addNewLink()async{
   Map<String, String> body = {
     'title': _titleCtl.text,
     'link': _linkCtl.text,
   };
      if(_keyForm.currentState!.validate()){

    ApiHelper apiResponse = await  LinksApiController().addLinks(body);
      if(apiResponse.success&&mounted){
        Navigator.pop(context);
      }
       snackBar(context, message: apiResponse.message,success: apiResponse.success);
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Link'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.grey.shade300,
      ),
      body: Form(
        key: _keyForm,
        child: Padding(
          padding: const EdgeInsets.all(33),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CustomTextFormField(controller: _titleCtl,validator: (v) {
                   if(v!.isEmpty){
                     return 'enter the title please';
                   }
                 },hintText: 'Snapchat', labelText: 'title'),
                const SizedBox(
                  height: 15,
                ),
                 CustomTextFormField(controller: _linkCtl,validator: (v) {
                   if(v!.isEmpty){
                     return 'enter the link please';
                   }
                 },
                    hintText: 'http:\\www.Example.com', labelText: 'link'),
                const SizedBox(
                  height: 40,
                ),
                SecondaryButtonWidget(title: 'ADD', width: 140, onTap: () {
                  addNewLink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
