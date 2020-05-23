import 'dart:async';

class LyraValidators{

  static Pattern _phoneRegX = r'^\d{4}-\d{4}$';

    final validateField = StreamTransformer<String, String>.fromHandlers(handleData: (txtField, sink){
    if(txtField.length > 0)
    {
      sink.add(txtField);
    }
    else{
      sink.addError("Enter the correct data");
    }
  });

   final validatePhone = StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    RegExp regExp = new RegExp(_phoneRegX);

    if (regExp.hasMatch(phone)) {
      sink.add(phone);
    } else {
      sink.addError('Número de teléfono inválido. Verifique los datos ingresados');
    }
  });

  
}