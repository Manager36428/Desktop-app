import QtQuick 2.0
import QtQuick.Controls 2.0
import "../components"
import "../common"
import QtGraphicalEffects 1.0

Popup{
    id: popupColorPicker
    height: 510
    width: 710
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width

    title : "Color Picker"
    property string currentColor: ""
    property alias newColor: newColorPreview.rect.color

    property color pickedColor: "#FFFFFF"
    property color inputedColor: "#FFFFFF"

    signal accepted();

    function syncColor(sync_color){
        tfcolorInHex.text = sync_color
        newColorPreview.rect.color = sync_color
        rgbColorSpace.colorValue = sync_color;
        hsvColorSpace.colorValue = sync_color;
        cmykColorSpace.colorValue = sync_color;
    }

    onPickedColorChanged: {
        syncColor(pickedColor)
    }

    onInputedColorChanged: {
        console.log("onInputedColorChanged : ", inputedColor)
        let hueV = utils.hsv_hue(inputedColor)
        let satF = utils.hsl_saturationF(inputedColor)
        let lightnessF = utils.hsl_lightnessF(inputedColor);
        rootItem.hueLevel = (hueSlider.height - 1) * hueV / 359
        var imageData = hueSlider.getContext("2d").getImageData(1, rootItem.hueLevel, 1, 1).data;
        rootItem.hueColor = Qt.rgba(imageData[0] / 255, imageData[1] / 255, imageData[2] / 255, imageData[3] / 255);

        console.log("Hue Value : ", hueV)
        console.log("New Hue Color : ", rootItem.hueColor)
        console.log("Hue : ", satF)
        console.log("Lightness : ", lightnessF)

        let newX = satF * colorArea.width;
        let newY = (1-lightnessF) * colorArea.height;
        rootItem.colorPos = {"x": newX,"y": newY}
        console.log("X - Y :" , rootItem.colorPos.x +" - " +rootItem.colorPos.y)
        colorArea.requestPaint();

        rgbColorSpace.emitColorChanged = false;
        hsvColorSpace.emitColorChanged = false;
        cmykColorSpace.emitColorChanged = false;

        syncColor(inputedColor)
    }


    function handleColorUpdated(){
        tfcolorInHex.text = newColor.toString().substring(1).toUpperCase();
    }

    content: Item{
        id : rootItem
        anchors.fill: parent

        property color hueColor: "red"
        property int hueLevel: 0
        property var colorPos: {"x":0, "y":0}

        function updateColor(x, y) {
            if(y > colorArea.height) y = colorArea.height - 1
            if(y < 0) y = 0
            if(x > colorArea.width) x = colorArea.width - 1
            if(x < 0) x = 0

            colorPos = {"x": x,"y": y}
            var ctx = colorArea.getContext("2d");
            var imageData = ctx.getImageData(x, y, 1, 1).data;
            var selectedColor = Qt.rgba(imageData[0] / 255, imageData[1] / 255, imageData[2] / 255, imageData[3] / 255);
            pickedColor = selectedColor;
            console.log("updateColor", x+ " - " + y)
        }

        function updateHue(y) {
            if(y > hueSlider.height- 1) y = hueSlider.height-1
            if(y < 0) y = 0

            hueLevel = y > hueSlider.height ? hueSlider.height : y
            var ctx = hueSlider.getContext("2d");
            var imageData = ctx.getImageData(0, y, 1, 1).data;
            console.log("updateHue", y)
            hueColor = Qt.rgba(imageData[0] / 255, imageData[1] / 255, imageData[2] / 255, imageData[3] / 255);

            colorArea.requestPaint();
            updateColor(colorPos.x,colorPos.y)
        }

        function toHex(value) {
            var hex = value.toString(16);
            return hex.length == 1 ? "0" + hex : hex;
        }

        function complementaryColor(rgbColor) {
            var r = Math.round(1 - rgbColor.r);
            var g = Math.round(1 - rgbColor.g);
            var b = Math.round(1 - rgbColor.b);
            return Qt.rgba(r, g, b, 1);
        }

        function reflectColor(new_color){

        }

        Canvas {
            id: colorArea
            width: 330
            height: 365
            anchors{
                top: parent.top
                left: parent.left
                leftMargin: 24
                topMargin: 16
            }
            z:10
            onPaint: {
                var ctx = getContext("2d");
                var width = colorArea.width;
                var height = colorArea.height;
                var radius = 10;

                ctx.clearRect(0, 0, width, height);

                var gradient = ctx.createLinearGradient(0, 0, width, 0);
                gradient.addColorStop(0, "white");
                gradient.addColorStop(1, rootItem.hueColor);

                var gradientVertical = ctx.createLinearGradient(0, 0, 0, height);
                gradientVertical.addColorStop(0, "rgba(255, 255, 255, 0)");
                gradientVertical.addColorStop(1, "rgba(0, 0, 0, 1)");

                ctx.fillStyle = gradient;
                ctx.fillRect(0, 0, width, height);
                ctx.fillStyle = gradientVertical;
                ctx.fillRect(0, 0, width, height);
            }

            MouseArea {
                id: colorAreaMouse
                anchors.fill: parent
                onClicked: {
                    colorArea.forceActiveFocus();
                    rootItem.updateColor(mouse.x, mouse.y)
                }

                onPositionChanged: if (mouse.buttons & Qt.LeftButton) rootItem.updateColor(mouse.x, mouse.y)
            }

            Image{
                id :colorIndicator
                source: "qrc:/assets/ic_circle_indicator.png"
                height: 12
                width: 12
                x: rootItem.colorPos.x - width / 2
                y: rootItem.colorPos.y - height / 2

                ColorOverlay{
                    id : overlayColorIndicator
                    anchors.fill: colorIndicator
                    source: colorIndicator
                    color: rootItem.complementaryColor(newColorPreview.rect.color)
                }
            }
        }

        Canvas {
            id: hueSlider
            antialiasing: true
            height: 364
            width: 20
            anchors{
                top: parent.top
                left: parent.left
                leftMargin: 376
                topMargin: 17
            }

            onPaint: {
                var ctx = getContext("2d");
                var width = hueSlider.width;
                var height = hueSlider.height;
                var gradient = ctx.createLinearGradient(0, 1, 0, height-1);

                gradient.addColorStop(0.0, "red");
                gradient.addColorStop(1/6, "yellow");
                gradient.addColorStop(2/6, "green");
                gradient.addColorStop(3/6, "cyan");
                gradient.addColorStop(4/6, "blue");
                gradient.addColorStop(5/6, "magenta");
                gradient.addColorStop(1.0, "red");

                ctx.fillStyle = gradient;
                ctx.fillRect(0, 0, width, height);

            }

            MouseArea {
                id: hueSliderMouse
                anchors.fill: parent
                onClicked: {
                    hueSlider.forceActiveFocus();
                    rootItem.updateHue(mouse.y)
                }

                onPositionChanged: if (mouse.buttons & Qt.LeftButton) rootItem.updateHue(mouse.y)
            }
        }

        Image{
            id :indicator
            source: "qrc:/assets/ic_indicator.png"
            height: 12
            width: 12
            anchors{
                right: hueSlider.left
                rightMargin: -2
                top: hueSlider.top
                topMargin: rootItem.hueLevel - indicator.height/2 + 1
            }
            ColorOverlay{
                anchors.fill: indicator
                source: indicator
                color: "white"
            }
        }

        Image{
            id :indicator2
            source: "qrc:/assets/ic_indicator.png"
            height: 12
            width: 12
            mirror: true
            anchors{
                left: hueSlider.right
                leftMargin: -2
                top: hueSlider.top
                topMargin: {
                    let pos = rootItem.hueLevel - indicator.height/2 + 1
                    return pos;
                }
            }
            ColorOverlay{
                anchors.fill: indicator2
                source: indicator2
                color: "white"
            }
        }

        ButtonText{
            btnName: "Pick Screen Color"
            width: 330
            height: 36
            anchors{
                top: colorArea.bottom
                left: parent.left
                margins: 24
            }
        }

        ButtonText{
            id :btnOk
            btnName: "Ok"
            width: 120
            anchors{
                top: parent.top
                right: parent.right
                topMargin: 16
                rightMargin: 13
            }
            onBtnClicked: {
                accepted()
                popupColorPicker.close();
            }
        }

        ButtonText{
            id :btnCancel
            btnName: "Cancel"
            width: 120
            anchors{
                top: parent.top
                right: parent.right
                topMargin: 68
                rightMargin: 13
            }
            onBtnClicked: popupColorPicker.close();
        }

        Item{
            id : colorShowing
            height: 128
            width: 121
            anchors{
                top: parent.top
                left: hueSlider.right
                topMargin: 9
                leftMargin: 24
            }

            Text {
                text: "New"
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
            }

            RectangleOneSideRounded{
                id: newColorPreview
                height: 41
                width: parent.width
                rect.color : currentColor
                rect.radius: 10
                anchors.top: parent.top
                anchors.topMargin: 23
                rect.border.width: 1
                rect.border.color: "white"
                onColorChanged: handleColorUpdated()
            }

            RectangleOneSideRounded{
                id: currentColorPreview
                height: 41
                width: parent.width
                rect.color : currentColor
                rect.radius: 10
                anchors.top: newColorPreview.bottom
                anchors.topMargin: -1
                side: "bottom"
                rect.border.width: 1
                rect.border.color: "white"
            }

            Text {
                text: "Current"
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
            }

        }

        ColorDisplay{
            id : hsvColorSpace
            width: 82
            height: 132
            anchors{
                top: colorShowing.bottom
                topMargin: 24
                left: hueSlider.right
                leftMargin: 41
            }
            colorSpace : "hsv"
            limitVales: [359,100,100,0]
            onColorChanged: inputedColor = newColor
        }

        ColorDisplay{
            id :rgbColorSpace
            colorSpace : "rgb"
            anchors{
                bottom: parent.bottom
                bottomMargin: 23
                left: hueSlider.right
                leftMargin: 41
            }
            onColorChanged: inputedColor = newColor
        }

        ColorDisplay{
            id : cmykColorSpace
            colorSpace: "cmyk"
            anchors{
                top: btnCancel.bottom
                topMargin: 51
                left: rgbColorSpace.right
                leftMargin: 66
            }
            limitVales: [100,100,100,100]
            onColorChanged: inputedColor = newColor
        }

        Item{
            height: 36
            width: 145
            anchors{
                right: parent.right
                bottom: parent.bottom
                rightMargin: 21
                bottomMargin: 23
            }

            Text {
                height: 16
                text: "#"
                color: "#4D365D"
                verticalAlignment: Text.AlignVCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 16
                anchors{
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
            }

            TextField{
                id : tfcolorInHex
                height: 40
                width: 124
                anchors.right: parent.right
                background: Rectangle{
                    antialiasing: true
                    color: "white"
                    radius: 10
                }

                onTextChanged: {
                    if(tfcolorInHex.activeFocus){
                        text = text.toUpperCase()
                        delayTimer.restart()
                    }
                }

                function edit(){
                    console.log("Editing Color")
                    let color_updated = "#" + text
                    if(text.length == 6 && utils.is_valid_color(color_updated)){
                        newColorPreview.forceActiveFocus()
                        inputedColor = color_updated
                    }else{
                        text = newColor.toString().substring(1).toUpperCase();
                    }
                }
                maximumLength: 6
                Timer{
                    id: delayTimer
                    interval: 500
                    onTriggered: parent.edit()
                    repeat: false
                }

                inputMask: "HHHHHH"

                color: "#585D6C"
                font.pixelSize: 16
                font.family: "Nunito"
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

        }
    }

}
