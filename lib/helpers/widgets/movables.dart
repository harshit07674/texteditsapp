

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'dart:math' as math;

class MoveableStackItem extends StatefulWidget {
  String data;

  MoveableStackItem({Key? key,required this.data});
  @override State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}
class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 50;
  double yPosition = 50;
  bool boldValue = false;
  Color boldIconColor = Colors.black;
  bool italicValue = false;
  Color italicIconColor = Colors.black;
  FontWeight weight = FontWeight.w500;
  FontStyle stylish = FontStyle.normal;
  Color color = Colors.transparent;
  Color textcolor = Colors.black;
  TextEditingController sizeNumber = TextEditingController();
  TextEditingController controller = TextEditingController();
  double size = 14.0;
  double rotation=0.0;
  String dropdownvalue = 'Roboto';
  var items = [
    'Roboto',
    'Poppins',
    'Dancing_Script',
    'Playfair_Display',
    'Oswald',
    'Quicksand',
    'Sofia',
    'Space_Grotesk'
  ];
  @override
  void initState() {
    setState(() {
      dropdownvalue=items[0];
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery
        .of(context)
        .size;
    return Positioned(
        top: yPosition,
        left: xPosition,
        child: GestureDetector(
            onPanUpdate: (tapInfo) {
              setState(() {
                color = Colors.black;
                xPosition += tapInfo.delta.dx;
                yPosition += tapInfo.delta.dy;
              });
            },
            onPanEnd: (tapInfo) {
              setState(() {
                color = Colors.transparent;
              });
            },
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context,
                            StateSetter sheetSetState
                            /*You can rename this!*/) {
                          return Container(
                            height: dimension.height * 0.14,
                            width: dimension.width,
                            margin: EdgeInsets.only(left: 30),
                            child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Color: ", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),),
                                      GestureDetector(
                                        onTap: () {
                                          ColorPicker(
                                            color: textcolor,
                                            onColorChanged: (Color color) {
                                              setState(() {
                                                sheetSetState(() {
                                                  textcolor = color;
                                                });
                                              });
                                            },
                                          ).showPickerDialog(
                                            context,
                                          );
                                        },

                                        child: Container(
                                          height: dimension.height * 0.03,
                                          width: dimension.width * 0.06,
                                          decoration: BoxDecoration(
                                            color: textcolor,
                                            borderRadius: BorderRadius.circular(
                                                30),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: [
                                      Text("Size: ", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),),
                                      Container(
                                          height: dimension.height * 0.03,
                                          width: dimension.width * 0.10,
                                          child: TextField(
                                            controller: sizeNumber,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(
                                                    10),
                                                hintText: "Number",
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue),
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                )
                                            ),
                                            onChanged: (number) {
                                              setState(() {
                                                sheetSetState(() {
                                                  String num = sizeNumber.text
                                                      .toString();
                                                  size = double.parse(num);
                                                });
                                              });
                                            },
                                          )
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: [
                                      Text("Font Type: ", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),),
                                      Container(
                                        height: dimension.height * 0.03,
                                        width: dimension.width * 0.2,
                                        child: DropdownButton(
                                          isExpanded: true,
// Initial Value
                                          value: dropdownvalue,

// Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),

// Array list of items
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
// After selecting the desired option,it will
// change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              sheetSetState(() {
                                                dropdownvalue = newValue!;
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Align(alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sheetSetState(() {
                                            boldValue = !boldValue;
                                            if (boldValue) {
                                              weight = FontWeight.bold;
                                              boldIconColor = Colors.blue;
                                            }
                                            else {
                                              weight = FontWeight.normal;
                                              boldIconColor = Colors.black;
                                            }
                                          });
                                        });
                                      }, child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: dimension.height * 0.04,
                                      width: dimension.width * 0.09,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(Icons.format_bold,
                                        color: boldIconColor,),
                                    ),),
                                  ),
                                  SizedBox(width: 20,),
                                  Align(alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sheetSetState(() {
                                            italicValue = !italicValue;
                                            if (italicValue) {
                                              stylish = FontStyle.italic;
                                              italicIconColor = Colors.blue;
                                            }
                                            else {
                                              stylish = FontStyle.normal;
                                              italicIconColor = Colors.black;
                                            }
                                          });
                                        });
                                      }, child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: dimension.height * 0.04,
                                      width: dimension.width * 0.09,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(Icons.format_italic,
                                        color: italicIconColor,),
                                    ),),
                                  ),
                                ])
                            ,);
                        }
                    );
                  });
            },
            onDoubleTap: () {
              setState(() {
                controller.text = widget.data;
              });
              showModalBottomSheet(context: context, builder: (context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter textSetState) {
                      return Container(
                        height: dimension.height * 0.2,
                        width: dimension.width,
                        margin: EdgeInsets.only(left: 30),
                        child: Center(child: Column(
                          children: [
                            Container(
                              height: dimension.height * 0.05,
                              width: dimension.width * 0.5,
                              margin: EdgeInsets.only(top: 10),
                              child: TextField(
                                controller: controller,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "enter text",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                                onChanged: (number) {
                                  setState(() {
                                    textSetState(() {
                                      String temp_data = controller.text
                                          .toString();
                                      widget.data = temp_data;
                                    });
                                  });
                                },
                              ),


                            ),

                            SizedBox(height: 30,),

                            Row(
                              children: [
                                SizedBox(width: dimension.width * 0.3,),
                                IconButton(onPressed: () {
                                  setState(() {
                                    rotation += 0.1;
                                  });
                                },
                                    icon: Icon(Icons.rotate_right_outlined,
                                      color: Colors.black, size: 40,)),
                                IconButton(onPressed: () {
                                  setState(() {
                                    rotation -= 0.1;
                                  });
                                },
                                    icon: Icon(Icons.rotate_left_outlined,
                                      color: Colors.black, size: 40,)),
                              ],
                            ),

                          ],
                        ),),
                      );
                    });
              });
            },
            child: Transform(
              transform: Matrix4.rotationZ(rotation),
              alignment: Alignment.topLeft,
              child: Container(
                child: Text("${widget.data}", style: TextStyle(color: textcolor,
                  fontSize: size,
                  fontWeight: weight,
                  fontStyle: stylish,
                  fontFamily: dropdownvalue,),),

                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: color)
                ),
              ),
            )
        )

    );
  }
  }
