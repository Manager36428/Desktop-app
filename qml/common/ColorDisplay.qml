import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    width: 82
    height: colorSpace.toUpperCase() == "CMYK" ?  171 : 132
    property color colorValue : undefined
    property string colorSpace : "rgb"
    property var limitVales: [255,255,255,255]

    property bool emitColorChanged : false
    property bool updatingColor : false

    function toHex(value) {
        var hex = value.toString(16);
        return hex.length == 1 ? "0" + hex : hex;
    }

    function rgbToHsv(r, g, b) {
      var max = Math.max(r, g, b), min = Math.min(r, g, b);
      var h, s, v = max;

      var d = max - min;
      s = max == 0 ? 0 : d / max;

      if (max == min) {
        h = 0; // achromatic
      } else {
        switch (max) {
          case r: h = (g - b) / d + (g < b ? 6 : 0); break;
          case g: h = (b - r) / d + 2; break;
          case b: h = (r - g) / d + 4; break;
        }

        h /= 6;
      }

      return [ h, s, v ];
    }

    function rgb2cmyk (r,g,b) {
     var computedC = 0;
     var computedM = 0;
     var computedY = 0;
     var computedK = 0;

     if (r==0 && g==0 && b==0) {
      computedK = 1;
      return [0,0,0,1];
     }

     computedC = 1 - (r);
     computedM = 1 - (g);
     computedY = 1 - (b);

     var minCMY = Math.min(computedC,
                  Math.min(computedM,computedY));
     computedC = (computedC - minCMY) / (1 - minCMY) ;
     computedM = (computedM - minCMY) / (1 - minCMY) ;
     computedY = (computedY - minCMY) / (1 - minCMY) ;
     computedK = minCMY;

     return [computedC,computedM,computedY,computedK];
    }

    function updateColorRGB(){
        tf1.text = colorValue.r*255
        tf2.text = colorValue.g*255
        tf3.text = colorValue.b*255
    }

    function updateColorHSV(){
        let hsvSpace = rgbToHsv(colorValue.r,colorValue.g,colorValue.b)
        console.log(hsvSpace)
        tf1.text = Math.round(hsvSpace[0]*360)
        tf2.text = Math.round(hsvSpace[1]*100)
        tf3.text = Math.round(hsvSpace[2]*100)
    }

    function updateColorCMYK(){
        let cmyk = rgb2cmyk(colorValue.r,colorValue.g,colorValue.b)
        console.log(cmyk)
        tf1.text = Math.round(cmyk[0]*100)
        tf2.text = Math.round(cmyk[1]*100)
        tf3.text = Math.round(cmyk[2]*100)
        tf4.text = Math.round(cmyk[3]*100)
    }

    function getColorRGB(){
        let newColor = "#" + toHex(parseInt(tf1.text)) + toHex(parseInt(tf2.text)) + toHex(parseInt(tf3.text));
        colorChanged(newColor);
    }

    signal colorChanged(var newColor);

    function updateColor(){
        if(updatingColor) return;
        console.log("Color : ", colorValue)
        switch(colorSpace.toUpperCase()){
        case "RGB":
            emitColorChanged = true
            getColorRGB();
            break;
        case "HSV":
            emitColorChanged = true
            break;
        case "CMYK":
            emitColorChanged = true
            break;
        }
    }

    onColorValueChanged: {
        if(emitColorChanged) return
        console.log("Color : ", colorValue)
        updatingColor = true
        switch(colorSpace.toUpperCase()){
        case "RGB":
            updateColorRGB();
            break;
        case "HSV":
            updateColorHSV();
            break;
        case "CMYK":
            updateColorCMYK();
            break;
        }
        updatingColor = false;
    }

    Column{
        spacing: colorSpace.toUpperCase() == "CMYK" ? 9 : 12
        anchors.fill: parent

        Item{
            width: parent.width
            height: 36
            Text {
                height: 36
                text: colorSpace.toUpperCase().charAt(0)
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    left: parent.left
                }
            }

            TextField{
                id : tf1
                height: 40
                width: 36
                anchors.centerIn: parent
                background: Rectangle{
                    antialiasing: true
                    color: "white"
                    radius: 10
                }
                color: "#585D6C"
                font.pixelSize: 12
                font.family: "Nunito"
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                onTextChanged: {
                    if(parseInt(text) > limitVales[0] ){
                        text = limitVales[0]
                        return
                    }
                    updateColor()
                }
                validator: IntValidator {bottom: 0; top: limitVales[0];}
            }

            Text {
                height: 36
                text: "o"
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    right: parent.right
                }
                visible: colorSpace.toUpperCase() == "HSV"
            }
        }

        Item{
            width: parent.width
            height: 36
            Text {
                height: 36
                text: colorSpace.toUpperCase().charAt(1)
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    left: parent.left
                }
            }

            TextField{
                id : tf2
                height: 40
                width: 36
                anchors.centerIn: parent
                background: Rectangle{
                    antialiasing: true
                    color: "#FFFFFF"
                    radius: 10
                }
                color: "#585D6C"
                font.pixelSize: 12
                font.family: "Nunito"
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                onTextChanged: {
                    if(parseInt(text) > limitVales[1] ){
                        text = limitVales[1]
                        return
                    }
                    updateColor()
                }
                validator: IntValidator {bottom: 0; top: limitVales[1];}
            }

            Text {
                height: 36
                text: "%"
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    right: parent.right
                }
                visible: colorSpace.toUpperCase() == "HSV"
            }
        }

        Item{
            width: parent.width
            height: 36
            Text {
                height: 36
                text: colorSpace.toUpperCase().charAt(2)
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    left: parent.left
                }
            }

            TextField{
                id : tf3
                height: 40
                width: 36
                anchors.centerIn: parent
                background: Rectangle{
                    antialiasing: true
                    color: "#FFFFFF"
                    radius: 10
                }
                color: "#585D6C"
                font.pixelSize: 12
                font.family: "Nunito"
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                onTextChanged: {
                    if(parseInt(text) > limitVales[2] ){
                        text = limitVales[2]
                        return
                    }
                    updateColor()
                }
                validator: IntValidator {bottom: 0; top: limitVales[2];}
            }

            Text {
                height: 36
                text: "%"
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    right: parent.right
                }
                visible: colorSpace.toUpperCase() == "HSV"
            }
        }

        Item{
            width: parent.width
            height: 36
            visible: colorSpace.toUpperCase() == "CMYK"
            Text {
                height: 36
                text: colorSpace.toUpperCase().charAt(3)
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    left: parent.left
                }
            }

            TextField{
                id : tf4
                height: 40
                width: 36
                anchors.centerIn: parent
                background: Rectangle{
                    antialiasing: true
                    color: "#FFFFFF"
                    radius: 10
                }
                color: "#585D6C"
                font.pixelSize: 12
                font.family: "Nunito"
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                onTextChanged: {
                    if(parseInt(text) > limitVales[3] ){
                        text = limitVales[3]
                        return
                    }
                    updateColor()
                }
            }

            Text {
                height: 36
                text: "%"
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    right: parent.right
                }
                visible: colorSpace.toUpperCase() == "HSV"
            }
        }

    }

}
