import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

Window {
    width: 740
    height: 480
    visible: true
    title: qsTr("Hello World")

    Item {
        id: styleEditor
        height: parent.height
        width: parent.width/2

        Rectangle {
            id: background
            anchors.fill: parent
            color: "#F9FF5A"
        }

        Rectangle {
            id: header
            width: parent.width
            height: 50
            color: "#868A01"

            Text {
                text: "Style Editor"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: 22
            }
        }

        ComboBox {
            id: comboBox
            width: parent.width
            model: ListModel {
                id: model
                ListElement { text: "LayoutA"; }
                ListElement { text: "LayoutB"; }
                ListElement { text: "ImgLayout"; }
            }

            background: Rectangle {
                color: "#868A01"
                radius: 4
            }

            onCurrentIndexChanged: {
                tabBar.currentIndex = currentIndex
            }

            anchors {
                top: header.bottom
                topMargin: 10
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
            }
        }

        TabBar {
           visible: false
           id: tabBar
           width: parent.width/2.5
           spacing: 6

           background: Rectangle {
               color: "#F9FF5A"
           }

           anchors {
               left: parent.left
               leftMargin: 10
               top: comboBox.bottom
               topMargin: 10
           }

           TabButton {
               text: "A"
           }

           TabButton {
               text: "B"
           }
        }

        StackLayout {
            id: stackLayout
            currentIndex: tabBar.currentIndex
            anchors {
                top: comboBox.bottom
                topMargin: 10
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
                bottom: parent.bottom
                bottomMargin: 60
            }

            Item {
                id: firstItem

                Rectangle {
                    anchors.fill: parent
                    color: "#858585"

                    CDVerticalTableA {
                        width: parent.width
                        height: parent.height
                    }
                }
            }

            Item {
                id: secondItem

                Rectangle {
                    anchors.fill: parent
                    color: "#858585"

                    CDVerticalTableB {
                        width: parent.width
                        height: parent.height
                    }
                }
            }
        }

        RowLayout {
            spacing: 6

            anchors {
                top: stackLayout.bottom
                right: stackLayout.right
                topMargin: 10
            }

            Button {
                text: "Save"
                background: Rectangle {
                    color: "#015F8A"
                }
            }

            Button {
                text: "Close"
                background: Rectangle {
                    color: "#868A01"
                }
            }
        }
    }

    Rectangle {
        z: 1
        id: mainRectangle
        height: parent.height
        width: parent.width - styleEditor.width
        border.width: 0
        radius: 0

        Gradient {
            id: mainGradient
            GradientStop {position: 0; color: "transparent"}
            GradientStop {position: 1; color: "transparent"}
        }

        states: [
            State {
                name: "solidColorState"
                PropertyChanges {
                    target: mainRectangle
                    color: "transparent"
                }
            },
            State {
                name: "gradientColorState"
                PropertyChanges {
                    target: mainRectangle
                    gradient: mainGradient
                }
            }
        ]

        anchors {
            left: styleEditor.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: 0
        }

        Rectangle {
            id: innerRect
            color: "black"
            width: mainRectangle.width
            height: 50
            anchors {
                left: parent.left
                leftMargin: 20
                right: parent.right
                rightMargin: 20
                topMargin: 20
                bottomMargin: 20
                top: parent.top
                bottom: parent.bottom
            }
        }

        Rectangle {
            visible: false
            id: topRect
            color: "black"
            height : 0
            width: mainRectangle.width
            anchors {
                topMargin: mainRectangle.top
            }

            Text {
                id: topRectText
                text: "test"
                font.pixelSize: 12
                color: "white"
                anchors.centerIn: parent
            }
        }

        Rectangle {
            visible: false
            id: bottomRect
            color: "black"
            width: mainRectangle.width
            height: 20
            anchors {
                bottom: mainRectangle.bottom
            }

            Text {
                id: bottomRectText
                text: "test"
                font.pixelSize: 12
                color: "white"
                anchors.centerIn: parent
            }
        }


        Text {
            id: mainText
            font.pixelSize: 12
            text: "test"
            anchors.centerIn: parent
            visible: false
        }

    }

    Rectangle {
        id: minorRectangle
        height: parent.height
        width: parent.width - styleEditor.width
        border.width: 0
        radius: 0

        Gradient {
            id: minorGradient
            GradientStop {position: 0; color: "transparent"}
            GradientStop {position: 1; color: "transparent"}
        }

        states: [
            State {
                name: "solidColorState"
                //when: tabBar.currentIndex === 0
                PropertyChanges {
                    target: minorRectangle
                    color: "transparent"
                }
            },
            State {
                name: "gradientColorState"
                //when: tabBar.currentIndex === 1
                PropertyChanges {
                    target: minorRectangle
                    gradient: minorGradient
                }
            }
        ]

        anchors {
            left: styleEditor.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: 0
        }
    }
}
