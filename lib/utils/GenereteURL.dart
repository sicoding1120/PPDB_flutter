// ignore_for_file: non_constant_identifier_names, file_names

String GeneratePaymentUrl(String name, int amount) {
  final encodedName = Uri.encodeComponent(name);
  return 'http://localhost:4000/payment?name=$encodedName&amount=$amount';
}
