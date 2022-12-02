import 'package:flutter/material.dart';
import 'package:get/get.dart';

var config = {
  "colors": {"grayPrimary": 0xFF64696E}
};

class TailWindAnalysis {
  late double fontSize;
  late FontWeight fontWeight;
  late Color color;
  Border? border;
  EdgeInsets? padding;
  BorderRadius? borderRadius;
  Color? backgroundColor;
  BoxConstraints? size;
  late Alignment alignment;
  late Axis flexDirection;
  late CrossAxisAlignment flexItems;
  late MainAxisAlignment flexJustify;
  double gap = 0;
  TailWindAnalysis() {
    fontSize = 16;
    color = Colors.black;
    fontWeight = FontWeight.normal;
    flexDirection = Axis.horizontal;
    flexItems = CrossAxisAlignment.start;
    flexJustify = MainAxisAlignment.start;
    alignment = Alignment.center;
  }

  _analysisConfigColr(Color color, String colorStr) {
    if (config["colors"]!.isNotEmpty) {
      var color0x = config["colors"]![colorStr];
      if (color0x != null) {
        color = Color(color0x);
      }
    }
    return color;
  }

  Color _strForColor(String colorStr) {
    Color color = Colors.transparent;
    switch (colorStr) {
      case "white":
        color = Colors.white;
        break;
      case "black":
        color = Colors.black;
        break;
      case "gray":
        color = Colors.black;
        break;
      case "red":
        color = Colors.red;
        break;
      case "yellow":
        color = Colors.yellow;
        break;
      case "blue":
        color = Colors.blue;
        break;
      default:
        color = _analysisConfigColr(color, colorStr);
        break;
    }
    return color;
  }

  Color _colorWithOpacity(Color color, double number) {
    return color.withOpacity(number * 0.001);
  }

  analysisFont(String fontStr) {
    if (fontStr.startsWith("font-")) {
      var fontSplite = fontStr.split("-");
      if (fontSplite.length > 0) {
        switch (fontSplite[1]) {
          case "bold":
            fontWeight = FontWeight.bold;
            break;
          case "medium":
            fontWeight = FontWeight.w500;
            break;
          case "base":
            fontSize = 16;
            break;
          default:
        }
      }
    }
  }

  analysisHeight(String heightStr) {
    if (heightStr.startsWith("h-")) {
      var heightStrSpli = heightStr.split("-");
      if (heightStrSpli.length > 0) {
        var number = double.tryParse(heightStrSpli[1]);
        if (number != null) {
          if (size != null) {
            size = BoxConstraints(
                minHeight: number * 4,
                maxHeight: number * 4,
                minWidth: size!.minWidth,
                maxWidth: size!.maxWidth);
          } else {
            size = BoxConstraints(minHeight: number * 4, maxHeight: number * 4);
          }
        }
      }
    }
  }

  analysisWidth(String widthStr) {
    if (widthStr.startsWith("w-")) {
      var widthStrSpli = widthStr.split("-");
      if (widthStrSpli.length > 0) {
        if (widthStrSpli[1].contains("full")) {
          if (size != null) {
            size = BoxConstraints(
                minHeight: size!.minHeight,
                maxHeight: size!.maxHeight,
                minWidth: Get.width,
                maxWidth: Get.width);
          } else {
            size = BoxConstraints(minWidth: Get.width, maxWidth: Get.width);
          }
        } else {
          var number = double.tryParse(widthStrSpli[1]);
          if (number != null) {
            var value = number * 4;
            if (size != null) {
              size = BoxConstraints(
                  minHeight: size!.minHeight,
                  maxHeight: size!.maxHeight,
                  minWidth: value,
                  maxWidth: value);
            } else {
              size = BoxConstraints(minWidth: value, maxWidth: value);
            }
          }
        }
      }
    }
  }

  analysisRadius(String radiusStr) {
    if (radiusStr.startsWith("rounded-")) {
      var radiusStrSpli = radiusStr.split("-");
      if (radiusStrSpli.length > 0) {
        borderRadius = BorderRadius.all(Radius.circular(9999));
      }
    } else if (radiusStr.startsWith("rounded")) {
      borderRadius = BorderRadius.all(Radius.circular(4));
    }
  }

  analysisBackground(String backgroundStr) {
    if (backgroundStr.startsWith("bg-")) {
      var backgroundStrSplit = backgroundStr.split("-");
      if (backgroundStrSplit.length > 0) {
        Color color = Colors.transparent;
        if (backgroundStrSplit.length >= 2) {
          color = _strForColor(backgroundStrSplit[1]);
        }
        if (backgroundStrSplit.length >= 3) {
          var number = double.tryParse(backgroundStrSplit[2]);
          if (number != null) {
            color = _colorWithOpacity(color, number);
          }
        }
        backgroundColor = color;
      }
    }
  }

  analysisPadding(String paddingStr) {
    if (paddingStr.startsWith("p-")) {
      var number = double.tryParse(paddingStr.split("-")[1]);
      if (number != null) {
        padding = EdgeInsets.all(number * 4);
      }
    }
    if (paddingStr.startsWith("px-")) {
      var number = double.tryParse(paddingStr.split("-")[1]);
      if (number != null) {
        if (padding != null) {
          padding = EdgeInsets.only(
              left: number * 4,
              top: padding!.top,
              bottom: padding!.bottom,
              right: number * 4);
        } else {
          padding = EdgeInsets.only(left: number * 4, right: number * 4);
        }
      }
    }
    if (paddingStr.startsWith("py-")) {
      var number = double.tryParse(paddingStr.split("-")[1]);
      if (number != null) {
        if (padding != null) {
          padding = EdgeInsets.only(
              top: number * 4,
              bottom: number * 4,
              left: padding!.left,
              right: padding!.right);
        } else {
          padding = EdgeInsets.only(top: number * 4, bottom: number * 4);
        }
      }
    }
  }

  analysisBorder(String borderStr) {
    double borderWidth = 0;
    Color borderColor = Colors.transparent;
    if (borderStr.startsWith("border")) {
      borderWidth = 1;
    }
    if (borderStr.startsWith("border-")) {
      var borderSplite = borderStr.split("-");
      if (borderSplite.length > 0) {
        var number = double.tryParse(borderSplite[1]);
        if (number != null) {
          borderWidth = number;
        } else {
          switch (borderSplite[1]) {
            case "white":
              borderColor = Colors.white;
              break;
            case "black":
              borderColor = Colors.black;
              break;
            default:
              break;
          }
        }
      }
    }

    if (borderStr != 0 && borderColor != Colors.transparent) {
      border = Border.all(
          color: borderColor,
          width: borderWidth,
          strokeAlign: StrokeAlign.outside);
    }
  }

  _analsysTextFont(String textStr) {
    switch (textStr) {
      case "xs":
        fontSize = 12;
        break;
      case "base":
        fontSize = 16;
        break;
      default:
    }
  }

  analysisText(String textStr) {
    if (textStr.startsWith("text-")) {
      var textSplite = textStr.split("-");
      if (textSplite.length > 0) {
        if (["xs,sm"].contains(textSplite[1])) {
          switch (textSplite[1]) {
            case "xs":
              fontSize = 12;
              break;
            case "sm":
              fontSize = 14;
              break;
            default:
          }
        } else {
          color = _strForColor(textSplite[1]);
        }
      }
    }
  }

  analysisFlex(String flexStr) {
    if (flexStr.startsWith("flex-")) {
      var flexStrSpli = flexStr.split("-");
      if (flexStrSpli.length > 0) {
        switch (flexStrSpli[1]) {
          case "row":
            flexDirection = Axis.horizontal;
            break;
          case "col":
            flexDirection = Axis.vertical;
            break;
          default:
        }
      }
    }
  }

  analysisItems(String itemsStr) {
    if (itemsStr.startsWith("items-")) {
      var itemsStrSpli = itemsStr.split("-");
      if (itemsStrSpli.length > 0) {
        switch (itemsStrSpli[1]) {
          case "center":
            flexItems = CrossAxisAlignment.center;
            _analysisAlignment();
            break;

          default:
        }
      }
    }
  }

  analysisJustify(String justifyStr) {
    if (justifyStr.startsWith("justify-")) {
      var justifyStrSpli = justifyStr.split("-");
      if (justifyStrSpli.length > 0) {
        switch (justifyStrSpli[1]) {
          case "center":
            flexJustify = MainAxisAlignment.center;
            _analysisAlignment();
            break;
          case "between":
            flexJustify = MainAxisAlignment.spaceBetween;
            break;
          default:
        }
      }
    }
  }

  _analysisAlignment() {
    if (flexItems == WrapCrossAlignment.center) {
      if (flexDirection == Axis.horizontal) {
        alignment = Alignment.centerLeft;
      } else {
        alignment = Alignment.topCenter;
      }
    }
    if (flexJustify == WrapAlignment.center) {
      if (flexDirection == Axis.horizontal) {
        alignment = Alignment.topCenter;
      } else {
        alignment = Alignment.centerLeft;
      }
    }
    if (flexJustify == WrapAlignment.center &&
        flexItems == WrapCrossAlignment.center) {
      alignment = Alignment.center;
    }
  }

  analysisGap(String gapStr) {
    if (gapStr.startsWith("gap-")) {
      var gapStrSpli = gapStr.split("-");
      if (gapStrSpli.length > 0) {
        var number = double.tryParse(gapStrSpli[1]);
        if (number != null) {
          gap = number * 4;
        }
      }
    }
  }
}

class Div {
  late String _ClassName;
  late dynamic _child;
  late List<String> _classNameList;
  late TailWindAnalysis _tailWindAnalysis;
  void Function()? _onClick;
  Div(dynamic child, {void Function()? onClick}) {
    _child = child;
    _ClassName = "";
    _classNameList = [];
    _tailWindAnalysis = TailWindAnalysis();
    _onClick = onClick;
  }

  analysis(String className) {
    _tailWindAnalysis.analysisFlex(className);
    _tailWindAnalysis.analysisItems(className);
    _tailWindAnalysis.analysisJustify(className);
    _tailWindAnalysis.analysisHeight(className);
    _tailWindAnalysis.analysisWidth(className);
    _tailWindAnalysis.analysisFont(className);
    _tailWindAnalysis.analysisText(className);
    _tailWindAnalysis.analysisBorder(className);
    _tailWindAnalysis.analysisPadding(className);
    _tailWindAnalysis.analysisRadius(className);
    _tailWindAnalysis.analysisBackground(className);
    _tailWindAnalysis.analysisGap(className);
  }

  Div className(String className) {
    var classNames = className.trim().split(" ");
    if (classNames.length > 0) {
      classNames.forEach((className) {
        if (className != "") {
          analysis(className);
        }
      });
    } else {
      analysis(className);
    }
    return this;
  }

  Widget build() {
    print(_tailWindAnalysis.alignment);
    List<Widget> newList = [];
    if (_child.runtimeType == String) {
      _child = Text(_child,
          style: TextStyle(
              color: _tailWindAnalysis.color,
              fontSize: _tailWindAnalysis.fontSize,
              fontWeight: _tailWindAnalysis.fontWeight));
    } else {
      var list = (_child as List);
      list.forEach((item) {
        newList.add(item);
        newList.add(SizedBox(
          height: _tailWindAnalysis.flexDirection == Axis.vertical
              ? _tailWindAnalysis.gap
              : 0,
          width: _tailWindAnalysis.flexDirection == Axis.horizontal
              ? _tailWindAnalysis.gap
              : 0,
        ));
      });
      newList.removeLast();
      _child = Flex(
          mainAxisAlignment: _tailWindAnalysis.flexJustify,
          crossAxisAlignment: _tailWindAnalysis.flexItems,
          direction: _tailWindAnalysis.flexDirection,
          children: newList);
    }

    return GestureDetector(
        onTap: _onClick,
        child: Container(
          constraints: _tailWindAnalysis.size,
          decoration: BoxDecoration(
              border: _tailWindAnalysis.border,
              borderRadius: _tailWindAnalysis.borderRadius,
              color: _tailWindAnalysis.backgroundColor),
          padding: _tailWindAnalysis.padding,
          alignment: _tailWindAnalysis.size != null &&
                  _tailWindAnalysis.size!.minHeight > 0 &&
                  _tailWindAnalysis.size!.minWidth > 0
              ? _tailWindAnalysis.alignment
              : null,
          child: _child,
        ));
  }
}
