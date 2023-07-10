import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.3

Item {
    property int leftSliderValue: 10
    property int rightSliderValue: 10
    property int topSliderValue: 10
    property int bottomSliderValue: 10
    property int sliderValue: 10

    Slider {
        id: leftSlider
        stepSize: 1
        from: 0
        to: 360
        value: leftSliderValue

        handle: Rectangle {
            x: leftSlider.leftPadding + leftSlider.visualPosition * (leftSlider.availableWidth - width)
            y: leftSlider.topPadding + leftSlider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: leftSlider.pressed ? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbebf"
            Label {
                anchors.centerIn: parent
                text: Number(leftSlider.value).toFixed()
            }
        }

        anchors {
            top: comboBoxBottom.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        onValueChanged: {
            leftSliderValue = leftSlider.value
            innerRect.anchors.leftMargin = leftSliderValue
        }

        background: Rectangle {
            x: leftSlider.leftPadding
            y: leftSlider.topPadding + leftSlider.availableHeight / 2 - height / 2
            implicitHeight: 4
            width: leftSlider.availableWidth
            height: implicitHeight
            radius: 13
            color: "#868A01"
        }
    }

    TextField {
        id: textFieldLeft
        height: 26
        text: leftSliderValue.toString()

        anchors {
            left: leftSlider.right
            verticalCenter: leftSlider.verticalCenter
            leftMargin: 10
        }

        onTextChanged: {
            leftSliderValue = parseInt(textFieldLeft.text)
            innerRect.anchors.leftMargin = leftSliderValue
        }
    }

    Slider {
        id: rightSlider
        stepSize: 1
        from: 0
        to: 360
        value: rightSliderValue

        handle: Rectangle {
            x: rightSlider.leftPadding + rightSlider.visualPosition * (rightSlider.availableWidth - width)
            y: rightSlider.topPadding + rightSlider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: rightSlider.pressed ? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbebf"
            Label {
                anchors.centerIn: parent
                text: Number(rightSlider.value).toFixed()
            }
        }

        anchors {
            top: leftSlider.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        onValueChanged: {
            rightSliderValue = rightSlider.value
            innerRect.anchors.rightMargin = rightSliderValue
        }

        background: Rectangle {
            x: rightSlider.leftPadding
            y: rightSlider.topPadding + rightSlider.availableHeight / 2 - height / 2
            implicitHeight: 4
            width: rightSlider.availableWidth
            height: implicitHeight
            radius: 13
            color: "#868A01"
        }
    }

    TextField {
        id: textFieldRight
        height: 26
        text: rightSliderValue.toString()


        anchors {
            left: rightSlider.right
            verticalCenter: rightSlider.verticalCenter
            leftMargin: 10
        }

        onTextChanged: {
            rightSliderValue = parseInt(textFieldRight.text)
            innerRect.anchors.rightMargin = rightSliderValue
        }
    }

    Slider {
        id: topSlider
        stepSize: 1
        from: 0
        to: 360
        value: topSliderValue

        handle: Rectangle {
            x: topSlider.leftPadding + topSlider.visualPosition * (topSlider.availableWidth - width)
            y: topSlider.topPadding + topSlider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: topSlider.pressed ? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbebf"
            Label {
                anchors.centerIn: parent
                text: Number(topSlider.value).toFixed()
            }
        }

        anchors {
            top: rightSlider.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        onValueChanged: {
            topSliderValue = topSlider.value
            innerRect.anchors.topMargin = topSliderValue
        }

        background: Rectangle {
            x: topSlider.leftPadding
            y: topSlider.topPadding + topSlider.availableHeight / 2 - height / 2
            implicitHeight: 4
            width: topSlider.availableWidth
            height: implicitHeight
            radius: 13
            color: "#868A01"
        }
    }

    TextField {
        id: textFieldTop
        height: 26
        text: topSliderValue.toString()

        anchors {
            left: topSlider.right
            verticalCenter: topSlider.verticalCenter
            leftMargin: 10
        }

        onTextChanged: {
            topSliderValue = parseInt(textFieldTop.text)
            innerRect.anchors.topMargin = topSliderValue
        }
    }

    Slider {
        id: bottomSlider
        stepSize: 1
        from: 0
        to: 360
        value: bottomSliderValue

        handle: Rectangle {
            x: bottomSlider.leftPadding + bottomSlider.visualPosition * (bottomSlider.availableWidth - width)
            y: bottomSlider.topPadding + bottomSlider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: bottomSlider.pressed ? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbebf"
            Label {
                anchors.centerIn: parent
                text: Number(bottomSlider.value).toFixed()
            }
        }

        anchors {
            top: topSlider.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        onValueChanged: {
            bottomSliderValue = bottomSlider.value
            bottomSlider.anchors.bottomMargin = bottomSliderValue
        }

        background: Rectangle {
            x: bottomSlider.leftPadding
            y: bottomSlider.topPadding + bottomSlider.availableHeight / 2 - height / 2
            implicitHeight: 4
            width: bottomSlider.availableWidth
            height: implicitHeight
            radius: 13
            color: "#868A01"
        }
    }

    TextField {
        id: textFieldBottom
        height: 26
        text: bottomSliderValue.toString()

        anchors {
            left: bottomSlider.right
            verticalCenter: bottomSlider.verticalCenter
            leftMargin: 10
        }

        onTextChanged: {
            bottomSliderValue = parseInt(textFieldBottom.text)
            innerRect.anchors.bottomMargin = bottomSliderValue
        }
    }

    Slider {
        id: slider
        stepSize: 1
        from: 0
        to: 360
        value: sliderValue

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitWidth: 26
            implicitHeight: 26
            radius: 13
            color: slider.pressed ? "#f0f0f0" : "#f6f6f6"
            border.color: "#bdbebf"
            Label {
                anchors.centerIn: parent
                text: Number(slider.value).toFixed()
            }
        }

        anchors {
            top: bottomSlider.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        onValueChanged: {
            leftSlider.value = slider.value
            rightSlider.value = slider.value
            topSlider.value = slider.value
            bottomSlider.value = slider.value
            textField.text = slider.value
        }

        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            implicitHeight: 4
            width: slider.availableWidth
            height: implicitHeight
            radius: 13
            color: "#868A01"
        }
    }

    TextField {
        id: textField
        height: 26
        text: sliderValue.toString()

        anchors {
            left: slider.right
            verticalCenter: slider.verticalCenter
            leftMargin: 10
        }

        onTextChanged: {
            sliderValue = parseInt(textField.text)
        }
    }
}



