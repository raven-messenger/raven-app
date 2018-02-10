import 'dart:convert';

class Encryption {

  String xor(String msg, String otp) {
    List<int> charValuesTemp = msg.codeUnits;
    List<int> otpValues = otp.codeUnits;
    List<int> charValues = new List(otpValues.length);

    for(int j = 0; j < charValuesTemp.length; j++ ) {
      charValues[j] = charValuesTemp[j];
    }


    if ( charValuesTemp.length < otpValues.length){
      for( int k = charValuesTemp.length; k < otpValues.length; k++) {
        charValues[k] = 0;
      }
    }
    List<int> cipher = new List(charValues.length);
    for(int i = 0; i < charValues.length; i++) {
      cipher[i] = charValues[i] ^ otpValues[i];
    }

    return UTF8.decode(cipher);
  }
}
