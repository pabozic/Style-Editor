import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Dialogs 1.0

Item {

    TextField {
        id: textField
        text: ""
        width: 320/2.136 - colorRec.width
        height: 25

        anchors {
            top: comboBox.bottom
            topMargin: 10
            left: parent.left
        }
    }

    Rectangle {
        id: colorRec
        width: 20
        height: 20
        color: "white"
        radius: 4


        anchors {
            top: textField.top
            topMargin: 2.5
            left: textField.right
            leftMargin: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorDialog.visible = true
            }
        }
    }

    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
        onAccepted: {
            colorRec.color = colorDialog.color;
            textField.text = colorDialog.color;
            mainRectangle.gradient.stops[0].color = colorDialog.color;
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
        Component.onCompleted: visible = false
    }

    TextField {
        id: textField2
        text: ""
        width: 320/2.136 - colorRec.width
        height: 25

        anchors {
            left: colorRec.right
            leftMargin: 10
        }
    }

    Rectangle {
        id: colorRec2
        width: 20
        height: 20
        color: "white"
        radius: 4


        anchors {
            top: textField2.top
            topMargin: 2.5
            left: textField2.right
            leftMargin: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorDialog2.visible = true
            }
        }
    }

    ColorDialog {
        //visible: false
        id: colorDialog2
        title: "Please choose a color"
        onAccepted: {
            colorRec2.color = colorDialog2.color;
            textField2.text = colorDialog2.color;
            mainRectangle.gradient.stops[1].color = colorDialog2.color;
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
        Component.onCompleted: visible = false
    }

    TextField {
        id: textFieldBG
        text: ""
        width: 320/2.136 - colorRec.width
        height: 25

        anchors {
            top: textField.bottom
            topMargin: 10
            left: parent.left
        }
    }

    Rectangle {
        id: colorRecBG
        width: 20
        height: 20
        color: "white"
        radius: 4


        anchors {
            top: textFieldBG.top
            topMargin: 2.5
            left: textFieldBG.right
            leftMargin: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorDialogBG.visible = true
            }
        }     
    }

    ColorDialog {
        id: colorDialogBG
        title: "Please choose a color"
        onAccepted: {
            colorRecBG.color = colorDialogBG.color
            textFieldBG.text = colorDialogBG.color
            minorRectangle.gradient.stops[0].color = colorDialogBG.color;
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
        Component.onCompleted: visible = false
    }

    TextField {
        id: textFieldBG2
        text: ""
        width: 320/2.136 - colorRec.width
        height: 25

        anchors {
            left: colorRecBG.right
            leftMargin: 10
            top: textFieldBG.top
        }
    }

    Rectangle {
        id: colorRecBG2
        width: 20
        height: 20
        color: "white"
        radius: 4


        anchors {
            top: textFieldBG2.top
            topMargin: 2.5
            left: textFieldBG2.right
            leftMargin: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorDialogBG2.visible = true
            }
        }
    }

    ColorDialog {
        id: colorDialogBG2
        title: "Please choose a color"
        onAccepted: {
            colorRecBG2.color = colorDialogBG2.color
            textFieldBG2.text = colorDialogBG2.color
            minorRectangle.gradient.stops[1].color = colorDialogBG2.color;
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
        Component.onCompleted: visible = false
    }
}
