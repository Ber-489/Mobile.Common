
part of 'register_screen.dart';

extension InputPhoneNumber on RegisterScreen {
  Widget _inputPhoneNumber() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        controller: controller.txtPhone,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Nhập số điện thoại",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
