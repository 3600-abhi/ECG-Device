class PatientPreviousDataClass {
  String Name = '';
  String age = '';
  List<DateAndTime> PatientPreviousDataList = [];
  PatientPreviousDataClass({required this.Name,required this.age});
}

class DateAndTime {
  String date = '';
  String time = '';
  DateAndTime({required this.date,required this.time});
}