import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/resources/constants.dart';

class PrivacyScreen extends StatefulWidget {
  PrivacyScreen();

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height - 50,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: 2000,
          width: double.infinity,
          color: APP_BACKGROUND,
          child: Column(
            children: [
              Text(
                title,
                style: titleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String title = "Política de Privacidad CIBIC";
TextStyle titleStyle = TextStyle();

String introduction =
    '¡Hola! Somos CIBIC, una red social cívica cuyo objetivo es replantear la forma en que todos los ciudadanos y ciudadanas participamos en la sociedad. Para CIBIC es de suma importancia la privacidad de los datos que recolecta, por consiguiente sólo se solicitarán al Usuario datos de carácter personal que serán utilizados para los servicios proveídos por CIBIC, o por terceros usuarios del sistema y/o terceros proveedores de servicios y contenidos.\n\n'
    'Para CIBIC, la privacidad de las personas, la confidencialidad y resguardo de sus datos personales es fundamental, por ello se compromete a asegurar que su información personal esté protegida y su privacidad respetada.\n\n'
    'Conforme a ello, la presente política de protección de datos personales detalla como CIBIC recolecta, trata y protege los datos personales que el usuario entregue o que CIBIC recoja a través de su aplicación móvil, sitio web (www.cibic.app), formularios y otros medios existentes o que pudieran llegar a existir, con el objeto de que el Usuario pueda decidir libre y voluntariamente si desea que sean recopilados y tratados por CIBIC. Por tanto, el tratamiento de sus datos personales se realizará conforme a lo establecido en la presente política.\n\n'
    'Es importante señalar que esta política no aplica a los datos que sean recolectados por terceros en otras aplicaciones, sitios web u otros medios, aun cuando éstos puedan estar enlazados con CIBIC. A mayor abundamiento, CIBIC no dispone de control alguno respecto de dichos sitios y, por tanto, no es responsable del contenido de éstos. CIBIC no tiene control del tratamiento de datos que ellos realizan, en tal caso, se deberá estar a lo que prescriba la política de privacidad de dichos sitios y/o redes sociales.\n\n'
    'El titular de los datos acepta que la información personal que los Usuarios suministran, entregan o envían, como aquella que legítimamente recaba CIBIC, va a ser utilizada de acuerdo con la presente política para el tratamiento de datos personales.\n\n'
    'Quien entrega sus datos personales, declara y garantiza que estos son exactos, veraces y propios, que no ha suplantado la identidad de otros y/o que no son datos de terceros, por tanto es el único responsable de los datos que proporciona a CIBIC.\n\n'
    'CIBIC ejerce controles de licitud y veracidad de la información recibida en la medida de lo posible y de conformidad a la normativa vigente. Por tanto, CIBIC no es responsable de cualquier infracción derivada de la ilicitud, ilegitimidad, alteración, mal uso, fraude o sanción derivado de la información que hayan entregado.\n\n'
    'El tratamiento de datos personales que realice CIBIC será en conformidad con la Ley 19.628 “Ley Protección a la Vida Privada”, sus modificaciones y las demás normas relacionadas con el resguardo, protección, reserva y confidencialidad de los datos personales.\n\n';
