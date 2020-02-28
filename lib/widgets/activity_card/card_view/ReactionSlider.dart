import 'package:flutter/material.dart';

class ReactionSlider extends StatefulWidget {
  @override
  _ReactionSliderState createState() => _ReactionSliderState();
}

class _ReactionSliderState extends State<ReactionSlider> {
  double reactValue = 2.0;


  Color reactColor()
  {
    switch(reactValue.floor())
    {
      case 0:
        return Color(0xffe43535);
      case 1:
        return Color(0xffea8414);
      case 2:
        return Color(0xfff2e131);
      case 3:
        return Color(0xff80d25c);
      default:
        return Color(0xff22ba8e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 40,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: Colors.transparent,
                trackHeight: 5.0,
                thumbColor: reactColor(),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
              ),
              child: Slider(
                value: reactValue,
                onChanged: (value) => setState(() {
                  reactValue = value;
                }),
                max: 4.0,
                min: 0.0,
                divisions: 4,
              ),
            )
    );
  }
}