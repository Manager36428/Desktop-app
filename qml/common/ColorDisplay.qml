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

    function getColorHSV(){
        let newColor = utils.color_from_hsv(parseInt(tf1.text) , parseInt(tf2.text),
                                            parseInt(tf3.text))
        console.log("New Colour HSV : ", newColor)
        colorChanged(newColor);
    }

    function getColorCMYK(){
        let newColor = utils.color_from_cmyk(parseInt(tf1.text) , parseInt(tf2.text),
                                             parseInt(tf3.text) , parseInt(tf4.text))
        console.log("New Colour CMYK : ", newColor)
        colorChanged(newColor);
    }

    signal colorChanged(var newColor);

    function updateColor(){
        if(updatingColor) return;
        console.log("Colour : ", colorValue)
        switch(colorSpace.toUpperCase()){
        case "RGB":
            emitColorChanged = true
            getColorRGB();
            break;
        case "HSV":
            emitColorChanged = true
            getColorHSV();
            break;
        case "CMYK":
            getColorCMYK();
            emitColorChanged = true
            break;
        }
    }

    onColorValueChanged: {
        if(emitColorChanged) return
        console.log("Colour : ", colorValue)
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

                MouseArea{
                    id : wheel
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: {
                        parent.forceActiveFocus();
                        parent.pressed(mouse)
                    }
                    onWheel: {
                        if(!tf1.activeFocus) return
                        let currentValue = parseInt(tf1.text)
                        if (wheel.angleDelta.y > 0) {
                            tf1.text = (currentValue + 1)
                        } else if (wheel.angleDelta.y < 0) {
                            tf1.text = (currentValue - 1)
                        }
                        tf1.selectAll()
                    }
                }

                property int clickCount: 0
                Timer {
                    id: clickTimer1
                    interval: 300
                    repeat: false
                    onTriggered: {
                        tf1.clickCount = 0
                    }
                }
                Timer{
                    id : selectAllTimer1
                    interval: 10
                    repeat: false
                    onTriggered: tf1.selectAll()
                }

                onPressed: {
                    clickCount += 1
                    if (clickCount == 1) {
                        clickTimer1.start()
                    } else if (clickCount == 2) {
                        selectAllTimer1.start()
                        clickCount = 0
                    }
                    console.log("Pressed Select ")
                }
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

                MouseArea{
                    id : wheel2
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: {
                        parent.forceActiveFocus();
                        parent.pressed(mouse)
                    }
                    onWheel: {
                        if(!tf2.activeFocus) return
                        let currentValue = parseInt(tf2.text)
                        if (wheel.angleDelta.y > 0) {
                            tf2.text = (currentValue + 1)
                        } else if (wheel.angleDelta.y < 0) {
                            tf2.text = (currentValue - 1)
                        }
                        tf2.selectAll()
                    }
                }

                property int clickCount: 0
                Timer {
                    id: clickTimer2
                    interval: 300
                    repeat: false
                    onTriggered: {
                        tf2.clickCount = 0
                    }
                }
                Timer{
                    id : selectAllTimer2
                    interval: 10
                    repeat: false
                    onTriggered: tf2.selectAll()
                }

                onPressed: {
                    clickCount += 1
                    if (clickCount == 1) {
                        clickTimer2.start()
                    } else if (clickCount == 2) {
                        selectAllTimer2.start()
                        clickCount = 0
                    }
                    console.log("Pressed Select ")
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

                MouseArea{
                    id : wheel3
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: {
                        parent.forceActiveFocus();
                        parent.pressed(mouse)
                    }
                    onWheel: {
                        if(!tf3.activeFocus) return
                        let currentValue = parseInt(tf3.text)
                        if (wheel.angleDelta.y > 0) {
                            tf3.text = (currentValue + 1)
                        } else if (wheel.angleDelta.y < 0) {
                            tf3.text = (currentValue - 1)
                        }
                        tf3.selectAll()
                    }
                }

                property int clickCount: 0
                Timer {
                    id: clickTimer3
                    interval: 300
                    repeat: false
                    onTriggered: {
                        tf3.clickCount = 0
                    }
                }
                Timer{
                    id : selectAllTimer3
                    interval: 10
                    repeat: false
                    onTriggered: tf3.selectAll()
                }

                onPressed: {
                    clickCount += 1
                    if (clickCount == 1) {
                        clickTimer3.start()
                    } else if (clickCount == 2) {
                        selectAllTimer3.start()
                        clickCount = 0
                    }
                    console.log("Pressed Select ")
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

                MouseArea{
                    id : wheel4
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: {
                        parent.forceActiveFocus();
                        parent.pressed(mouse)
                    }
                    onWheel: {
                        if(!tf4.activeFocus) return
                        let currentValue = parseInt(tf4.text)
                        if (wheel.angleDelta.y > 0) {
                            tf4.text = (currentValue + 1)
                        } else if (wheel.angleDelta.y < 0) {
                            tf4.text = (currentValue - 1)
                        }
                        tf4.selectAll()
                    }
                }


                property int clickCount: 0
                Timer {
                    id: clickTimer4
                    interval: 300
                    repeat: false
                    onTriggered: {
                        tf4.clickCount = 0
                    }
                }
                Timer{
                    id : selectAllTimer4
                    interval: 10
                    repeat: false
                    onTriggered: tf4.selectAll()
                }

                onPressed: {
                    clickCount += 1
                    if (clickCount == 1) {
                        clickTimer4.start()
                    } else if (clickCount == 2) {
                        selectAllTimer4.start()
                        clickCount = 0
                    }
                    console.log("Pressed Select ")
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
