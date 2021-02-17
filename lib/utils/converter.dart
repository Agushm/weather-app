import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final formatter = NumberFormat("#,##0", "in_ID");

final formatRupiah = NumberFormat("Rp" + "#,##0", "in_ID");

String checkFormatNominal(String nominal) {
  if (nominal.contains('.')) {
    var data = nominal.split('.');
    return data[0];
  } else {
    return nominal;
  }
}

String formatTglTransaksi(DateTime tgl) {
  final fDate = DateFormat('yyyy-MM-dd hh:mm');
  var newData = fDate.format(tgl);
  return newData;
}

String tanggal(DateTime date, {bool shortMonth = false}) {
  return "${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year}";
}

String tanggalWithTime(DateTime date, {bool shortMonth = false}) {
  return "${_convertToLocalDay(date.weekday)}, ${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year} ${date.hour}:${date.minute}";
}

String convertJam(DateTime date) {
  final fDate = DateFormat('HH:mm');
  var d = fDate.format(date);
  return d;
}

List _longMonth = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];
List _shortMonth = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des'
];

List _longDay = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  "Jumat",
  'Sabtu',
  'Minggu'
];

String _convertToLocalDay(int day) {
  //if (shortMonth) return _shortMonth[month - 1];
  return _longDay[day - 1];
}

String _convertToLocalMonth(int month, bool shortMonth) {
  if (shortMonth) return _shortMonth[month - 1];
  return _longMonth[month - 1];
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = double.parse(newValue.text);
    String newText = formatRupiah.format(value);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
