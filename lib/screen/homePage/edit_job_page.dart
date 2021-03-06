import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo2/common_widget/show_alert_dialog.dart';
import 'package:flutter_demo2/common_widget/show_exception_alert_dialog.dart';
import 'package:flutter_demo2/models/job.dart';
import 'package:flutter_demo2/services/Database.dart';
import 'package:provider/provider.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, @required this.dataBase, this.job}) : super(key: key);

  final DataBase dataBase;
  final Job job ;

  static Future<void> show(BuildContext context , {Job job}) async {
    final database = Provider.of<DataBase>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditJobPage(
        dataBase: database,
        job: job,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;

  int _ratePerHour;


  @override
  void initState() {
    super.initState() ;
    if(widget.job != null)
      {
        _name = widget.job.name ;
        _ratePerHour = widget.job.ratePerHour ;
      }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        // for checking if the name is existing or not
        final jobs = await widget.dataBase.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if(widget.job != null)
          {
            allNames.remove(widget.job.name);
          }
        if (allNames.contains(_name)) {
          showAlertDialog(
            context,
            title: 'Name already used ',
            content: 'Please choose a different job name',
            defaultActionText: 'Ok',
          );
        }
        else
          {
            final id = widget.job?.id ?? documentIdFormCurrentDate() ;
            final job = Job(name: _name, ratePerHour: _ratePerHour , id: id);
            await widget.dataBase.setJob(job);
            Navigator.of(context).pop();
          }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Operation failed',
          exception: e,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text( widget.job  == null ? 'New Job' : 'Edit Job'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: _submit,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ))
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job name'),
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate per hour'),
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
