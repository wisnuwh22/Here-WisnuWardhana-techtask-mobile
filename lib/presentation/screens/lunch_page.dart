import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/application/validators/lunch_page_validator.dart';
import 'package:tech_task/domain/settings/constants.dart';
import 'package:tech_task/domain/settings/preference.dart';
import 'package:tech_task/presentation/widgets/warning_dialog.dart';

class LunchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LunchState();
  }
}

class _LunchState extends State<LunchPage> {

  TextEditingController _lunchDatePickerController = new MaskedTextController(mask: DATE_TIME_MASK);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loadsmile Lunch App'),
      ),
      body: _buildPage(context),
    );
  }

  // widget to build the entire page
  Widget _buildPage(BuildContext context) {

    final children = <Widget>[];

    final lunchDate = _buildLunchDate(context);
    children.add(_buildLabel('Lunch Date'));
    children.add(lunchDate);

    final submitButton = _buildSubmitButton(context);
    children.add(submitButton);
    
    return ListView(
      padding: EdgeInsets.zero,
      children: children,
    );
  }

  // widget label
  Widget _buildLabel(String label) {
    final labelContainer =  Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          ),
        ),
     );
    return labelContainer;
  }

  // Text field widget to show choosen lunch date
  Widget _buildLunchDate(BuildContext context) {

    final lunchDate = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
        controller: _lunchDatePickerController,
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: InkResponse(
            onTap: () => _selectDate(context, _lunchDatePickerController),
            child: Icon(Icons.date_range),
          ),
        ),
      ),
    );

    return lunchDate;
  }

  // Showing Datepicer to pick lunch date
  Future<Null> _selectDate(BuildContext context, TextEditingController _datePickerController) async {
    DateTime selectedDate = DateTime.now();
    final DateTime pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2019, 1, 1),
        initialDate: selectedDate,
        lastDate: DateTime(2020, 12, 31));
    if (pickedDate != null)
      setState(() {
        selectedDate = pickedDate;
        _datePickerController.text = DateFormat(DATE_TIME_FORMAT).format(selectedDate);
      },
    );
  }

  // Submit button widget to progress to next page
  Widget _buildSubmitButton(BuildContext context) {
    final submitButton = Container(
      margin: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.07,
      child: RaisedButton(
        onPressed: (){
          DateTime _lunhcDate ;
          
          // if empty, lunch date is today date
          if(_lunchDatePickerController.text.isEmpty) 
            _lunhcDate = DateTime.now();
          
          // if not empty, check validation
          else { 
            String err = LunchPageValidator.validateLunchDate(_lunchDatePickerController.text);
            if(err == null) {
              _lunhcDate = DateTime.parse(_lunchDatePickerController.text);
            }
            // if not valid, display error message
            else {
              _lunhcDate = null;
              WarningDialog.getInstance().showWarningDialog(context, err);
            }
          }
          
          // if no error, save lunch date to shared preference
          // then go to next page
          if(_lunhcDate != null) {
            setLunchDate(DateFormat(DATE_TIME_FORMAT).format(_lunhcDate));
            Navigator.pushNamed(context, INGREDIENT_PAGE_ROUTE);
          }
          
        },
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Text('Get Ingredients',
          textAlign: TextAlign.center, style: TextStyle(color: Colors.white),
        ),
      ),
    );
    
    return submitButton;
  }

}