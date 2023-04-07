part of 'login_screen.dart';

extension InputForm on LoginScreen {
  Widget _inputForm({required TextEditingController controller, required String hintText,TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
