import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_budget/MainScreen.dart';


class AddInitialAmount extends StatefulWidget {
  final String name;
  final String currency;

  const AddInitialAmount({super.key, required this.name, required this.currency});

  @override
  State<AddInitialAmount> createState() => _AddInitialAmountState();
}

class _AddInitialAmountState extends State<AddInitialAmount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();



  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }


// Function to get the currency symbol
  String getCurrencySymbol(String currency) {
    if (currency.startsWith('USD')) return 'USD \$';
    if (currency.startsWith('EUR')) return 'EUR €';
    if (currency.startsWith('GBP')) return 'GBP £';
    if (currency.startsWith('JPY')) return 'JPY ¥';
    if (currency.startsWith('INR')) return 'INR ₹';
    if (currency.startsWith('AUD')) return 'AUD \$';
    if (currency.startsWith('CAD')) return 'CAD \$';
    if (currency.startsWith('CHF')) return 'CHF Fr.';
    if (currency.startsWith('CNY')) return 'CNY ¥';
    if (currency.startsWith('PKR')) return 'PKR Rs';
    if (currency.startsWith('AFN')) return 'AFN ؋';
    if (currency.startsWith('ALL')) return 'ALL Lek';
    if (currency.startsWith('AMD')) return 'AMD ֏';
    if (currency.startsWith('ANG')) return 'ANG ƒ';
    if (currency.startsWith('AOA')) return 'AOA Kz';
    if (currency.startsWith('ARS')) return 'ARS ';
    if (currency.startsWith('AWG')) return 'AWG ƒ';
    if (currency.startsWith('AZN')) return 'AZN ₼';
    if (currency.startsWith('BAM')) return 'BAM KM';
    if (currency.startsWith('BBD')) return 'BBD ';
    if (currency.startsWith('BDT')) return 'BDT ৳';
    if (currency.startsWith('BGN')) return 'BGN лв';
    if (currency.startsWith('BHD')) return 'BHD .د.ب';
    if (currency.startsWith('BIF')) return 'BIF FBu';
    if (currency.startsWith('BMD')) return 'BMD ';
    if (currency.startsWith('BND')) return 'BND ';
    if (currency.startsWith('BOB')) return 'BOB Bs';
    if (currency.startsWith('BRL')) return 'BRL R';
    if (currency.startsWith('BSD')) return 'BSD ';
    if (currency.startsWith('BTN')) return 'BTN Nu.';
    if (currency.startsWith('BWP')) return 'BWP P';
    if (currency.startsWith('BYN')) return 'BYN Br';
    if (currency.startsWith('BZD')) return 'BZD ';
    if (currency.startsWith('CDF')) return 'CDF FC';
    if (currency.startsWith('CLP')) return 'CLP ';
    if (currency.startsWith('COP')) return 'COP ';
    if (currency.startsWith('CRC')) return 'CRC ₡';
    if (currency.startsWith('CUP')) return 'CUP ₱';
    if (currency.startsWith('CVE')) return 'CVE ';
    if (currency.startsWith('CZK')) return 'CZK Kč';
    if (currency.startsWith('DJF')) return 'DJF Fdj';
    if (currency.startsWith('DKK')) return 'DKK kr';
    if (currency.startsWith('DOP')) return 'DOP RD';
    if (currency.startsWith('DZD')) return 'DZD دج';
    if (currency.startsWith('EGP')) return 'EGP £';
    if (currency.startsWith('ERN')) return 'ERN Nfk';
    if (currency.startsWith('ETB')) return 'ETB Br';
    if (currency.startsWith('FJD')) return 'FJD ';
    if (currency.startsWith('FKP')) return 'FKP £';
    if (currency.startsWith('GEL')) return 'GEL ₾';
    if (currency.startsWith('GHS')) return 'GHS ₵';
    if (currency.startsWith('GIP')) return 'GIP £';
    if (currency.startsWith('GMD')) return 'GMD D';
    if (currency.startsWith('GNF')) return 'GNF FG';
    if (currency.startsWith('GTQ')) return 'GTQ Q';
    if (currency.startsWith('GYD')) return 'GYD ';
    if (currency.startsWith('HKD')) return 'HKD ';
    if (currency.startsWith('HNL')) return 'HNL L';
    if (currency.startsWith('HRK')) return 'HRK kn';
    if (currency.startsWith('HTG')) return 'HTG G';
    if (currency.startsWith('HUF')) return 'HUF Ft';
    if (currency.startsWith('IDR')) return 'IDR Rp';
    if (currency.startsWith('ILS')) return 'ILS ₪';
    if (currency.startsWith('IQD')) return 'IQD ع.د';
    if (currency.startsWith('IRR')) return 'IRR ﷼';
    if (currency.startsWith('ISK')) return 'ISK kr';
    if (currency.startsWith('JMD')) return 'JMD ';
    if (currency.startsWith('JOD')) return 'JOD د.ا';
    if (currency.startsWith('KES')) return 'KES Sh';
    if (currency.startsWith('KGS')) return 'KGS с';
    if (currency.startsWith('KHR')) return 'KHR ៛';
    if (currency.startsWith('KID')) return 'KID ';
    if (currency.startsWith('KMF')) return 'KMF CF';
    if (currency.startsWith('KRW')) return 'KRW ₩';
    if (currency.startsWith('KWD')) return 'KWD د.ك';
    if (currency.startsWith('KYD')) return 'KYD ';
    if (currency.startsWith('KZT')) return 'KZT ₸';
    if (currency.startsWith('LAK')) return 'LAK ₭';
    if (currency.startsWith('LBP')) return 'LBP ل.ل';
    if (currency.startsWith('LKR')) return 'LKR Rs';
    if (currency.startsWith('LRD')) return 'LRD ';
    if (currency.startsWith('LSL')) return 'LSL L';
    if (currency.startsWith('LYD')) return 'LYD ل.د';
    if (currency.startsWith('MAD')) return 'MAD د.م.';
    if (currency.startsWith('MDL')) return 'MDL Lei';
    if (currency.startsWith('MGA')) return 'MGA Ar';
    if (currency.startsWith('MKD')) return 'MKD ден';
    if (currency.startsWith('MMK')) return 'MMK K';
    if (currency.startsWith('MNT')) return 'MNT ₮';
    if (currency.startsWith('MOP')) return 'MOP P';
    if (currency.startsWith('MRO')) return 'MRO UM';
    if (currency.startsWith('MTL')) return 'MTL Lm';
    if (currency.startsWith('MUR')) return 'MUR Rs';
    if (currency.startsWith('MVR')) return 'MVR ރ';
    if (currency.startsWith('MWK')) return 'MWK MK';
    if (currency.startsWith('MXN')) return 'MXN ';
    if (currency.startsWith('MYR')) return 'MYR RM';
    if (currency.startsWith('MZN')) return 'MZN MT';
    if (currency.startsWith('NAD')) return 'NAD ';
    if (currency.startsWith('NGN')) return 'NGN ₦';
    if (currency.startsWith('NIO')) return 'NIO C';
    if (currency.startsWith('NOK')) return 'NOK kr';
    if (currency.startsWith('NPR')) return 'NPR रू';
    if (currency.startsWith('NZD')) return 'NZD ';
    if (currency.startsWith('OMR')) return 'OMR ﷼';
    if (currency.startsWith('PAB')) return 'PAB B/.';
    if (currency.startsWith('PEN')) return 'PEN S/';
    if (currency.startsWith('PGK')) return 'PGK K';
    if (currency.startsWith('PHP')) return 'PHP ₱';
    if (currency.startsWith('PKR')) return 'PKR Rs';
    if (currency.startsWith('PLN')) return 'PLN zł';
    if (currency.startsWith('PYG')) return 'PYG ₲';
    if (currency.startsWith('QAR')) return 'QAR ﷼';
    if (currency.startsWith('RON')) return 'RON lei';
    if (currency.startsWith('RSD')) return 'RSD дин.';
    if (currency.startsWith('RUB')) return 'RUB ₽';
    if (currency.startsWith('RWF')) return 'RWF Fr';
    if (currency.startsWith('SAR')) return 'SAR ر.س';
    if (currency.startsWith('SBD')) return 'SBD ';
    if (currency.startsWith('SCR')) return 'SCR ₨';
    if (currency.startsWith('SDG')) return 'SDG ج.س.';
    if (currency.startsWith('SEK')) return 'SEK kr';
    if (currency.startsWith('SGD')) return 'SGD ';
    if (currency.startsWith('SHP')) return 'SHP £';
    if (currency.startsWith('SLL')) return 'SLL Le';
    if (currency.startsWith('SOS')) return 'SOS Sh';
    if (currency.startsWith('SRD')) return 'SRD ';
    if (currency.startsWith('SSP')) return 'SSP £';
    if (currency.startsWith('STN')) return 'STN Db';
    if (currency.startsWith('SYP')) return 'SYP £';
    if (currency.startsWith('SZL')) return 'SZL E';
    if (currency.startsWith('THB')) return 'THB ฿';
    if (currency.startsWith('TJS')) return 'TJS ЅМ';
    if (currency.startsWith('TMT')) return 'TMT m';
    if (currency.startsWith('TND')) return 'TND د.ت';
    if (currency.startsWith('TOP')) return 'TOP ';
    if (currency.startsWith('TRY')) return 'TRY ₺';
    if (currency.startsWith('TTD')) return 'TTD ';
    if (currency.startsWith('TVD')) return 'TVD ';
    if (currency.startsWith('TZS')) return 'TZS Sh';
    if (currency.startsWith('UAH')) return 'UAH ₴';
    if (currency.startsWith('UGX')) return 'UGX Sh';
    if (currency.startsWith('UYU')) return 'UYU ';
    if (currency.startsWith('UZS')) return 'UZS so\'m';
    if (currency.startsWith('VES')) return 'VES Bs.S';
    if (currency.startsWith('VND')) return 'VND ₫';
    if (currency.startsWith('VUV')) return 'VUV Vt';
    if (currency.startsWith('WST')) return 'WST T';
    if (currency.startsWith('XAF')) return 'XAF FCFA';
    if (currency.startsWith('XAG')) return 'XAG XAG';
    if (currency.startsWith('XAU')) return 'XAU XAU';
    if (currency.startsWith('XCD')) return 'XCD ';
    if (currency.startsWith('XDR')) return 'XDR SDR';
    if (currency.startsWith('XOF')) return 'XOF CFA';
    if (currency.startsWith('XPF')) return 'XPF ₣';
    if (currency.startsWith('YER')) return 'YER ﷼';
    if (currency.startsWith('ZAR')) return 'ZAR R';
    if (currency.startsWith('ZMW')) return 'ZMW ZK';
    if (currency.startsWith('ZWL')) return 'ZWL Z';
    return '';
  }


  Future<void> _saveInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', widget.name);
    await prefs.setString('userCurrency', widget.currency);
    await prefs.setDouble('initialAmount', double.parse(_amountController.text));
    await prefs.setBool('isInitialSetupComplete', true); // Mark initial setup as complete
  }

  @override
  Widget build(BuildContext context) {
    String currencySymbol = getCurrencySymbol(widget.currency);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Initial Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "How much money do you have in your\n cashwallet?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number, // Accept only numeric input
                decoration: InputDecoration(
                  hintText: 'Enter amount in $currencySymbol',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {

                    _saveInitialData().then((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Mainscreen()),
                      );
                    });
                  }
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange,
                  ),
                  child: Center(
                    child: Text(
                      "Finish",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              InkWell(
                child: Text("Skip",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey,
                ),),
                onTap: (){
                  _saveInitialData().then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Mainscreen()),
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
