import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.3


Rectangle {
  id: root
  color: "#F9FF5A"
  clip: true

  property var expandedRows: []
  property var leadingHeaders: [];
  property var detailFields: {
    if(m_model.length == 0)
      return [];

    var cols = [];
    cols = Object.keys(m_model[0]);

    for(var i = 0; i < root.leadingHeaders.length; i++) {
      cols.splice(cols.indexOf(root.leadingHeaders[i]), 1);
    }
    return cols;
  }

  property var m_model: [
        { },
        { },
        { },
        { }
  ]


  // Aliasing

  property color baseColor: "#171717"
  property int detailsHeight: 870
  property bool multiExpansion: false
  property bool maDetailsEnabled: false

  // Signalisasja
  signal tableTouched(int rowIndex)
  signal rowExpanded(int rowIndex)
  signal rowShrunk(int rowIndex)

  signal headerEntered(string fieldName)
  signal headerExited(string fieldName)
  signal cellEntered(int rowIndex, string fieldName);
  signal cellExited(int rowIndex, string fieldName);
  signal rowPressAndHold(int rowIndex);
  signal headerPressAndHold(string fieldName);
  signal tableRightClick(int rowIndex);

  // ------------------------------------ LE ANDROID STATE XD
  property int iDelHeaderHeight: 90
  property int iDelValueFontSize: 24
  property int iDelHeaderFontSize: 18
  property int iDelWidth: (root.width - 20) / 3
  property int iDelHeight: 50

  property int detailGridHeight: 9

  property var headerColumnWidths: []
  property var detailColumnWidths: ({})

  onRowPressAndHold: {
    if(rowIndex != expandedRows[0])
      selectRow(rowIndex);
  }

  function selectRow(rowIndex) {
    if(multiExpansion) {
      if(expandedRows.includes(rowIndex)) {
        expandedRows.splice(expandedRows.indexOf(rowIndex), 1);
        expandedRows = expandedRows;
        rowShrunk(rowIndex);
      }
      else {
        expandedRows.push(rowIndex);
        expandedRows = expandedRows;
        rowExpanded(rowIndex);
      }
    }
    else {
      if(expandedRows.includes(rowIndex)) {
        expandedRows = [];
        rowShrunk(rowIndex);
      }

      else {
        expandedRows = [rowIndex];
        rowExpanded(rowIndex);
      }
    }
  }


  Component {
    id: recipeDelegate

    Item {
      id: iLeader
      property int rowIndex: index
      property real detailsOpacity : 0

      width: listView.width
      height: iDelHeight


      Rectangle {
        id: background
        x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
        color: index % 2 ? Qt.lighter(root.baseColor, 1.5) : Qt.lighter(root.baseColor, 2)
        border.width: 0
        border.color: "dodgerblue"
      }

      MouseArea {
        id: maRow
        anchors.fill: parent

        pressAndHoldInterval: 200
        acceptedButtons: Qt.RightButton | Qt.LeftButton
        onPressAndHold: {
          rowPressAndHold(index);
        }

        onClicked: {
          tableTouched(index);
          if(mouse != undefined && mouse.button == Qt.RightButton) {
              tableRightClick(index);
          }

          else {
            print("yay dodged rightclick");
            if(multiExpansion) {
              if(expandedRows.includes(index)) {
                expandedRows.splice(expandedRows.indexOf(index), 1);
                expandedRows = expandedRows;
                rowShrunk(index);
              }
              else {
                expandedRows.push(index);
                expandedRows = expandedRows;
                rowExpanded(index);
              }
            }
            else {
              if(expandedRows.includes(index)) {
                expandedRows = [];
                rowShrunk(index);
              }

              else {
                expandedRows = [index];
                rowExpanded(index);
              }
            }
          }

          print("ExpandedRows = " + JSON.stringify(root.expandedRows))
        }
      }

      Item {
        id: topLayout
        x: 5; y: 5;
        height: iDelHeight; width: parent.width

        ListModel {
            id: textModel
            ListElement { text: "Base - properties"}
            ListElement { text: "TopRect - properties"}
            ListElement { text: "Bottom - properties" }
            ListElement { text: "InerCenterRect - properties" }
        }

        Text {
            text: textModel.get(index).text
            font.pixelSize: 20
            color: "white"
            font.family: "Arial"

            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 10
                topMargin: 4
            }
        }

        Row {
          anchors.fill: parent
          spacing: 5

          Repeater {
            id: rLeaders
            model: leadingHeaders.length

            delegate: Rectangle {
              id: leaderDelegate
              property string fieldName: m_model[iLeader.rowIndex][leadingHeaders[index]]
              visible: true
              width: headerColumnWidths[index]
              height: parent.height
              color: "transparent"

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                propagateComposedEvents: true
                onEntered: root.headerEntered(leaderDelegate.fieldName);
                onExited: root.headerEntered(leaderDelegate.fieldName);
                onPressAndHold: {
                  root.headerPressAndHold(leaderDelegate.fieldName)
                  root.rowPressAndHold(iLeader.rowIndex)
                }
              }

              Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                  GradientStop {
                    color: "#239999AA"
                    position: 0
                  }
                  GradientStop {
                    color: "#119999AA"
                    position: 0.85
                  }
                }
              }

              DetailDelegate {
                anchors.fill: parent
                value: m_model[iLeader.rowIndex][leadingHeaders[index]];
                label: leadingHeaders[index];

                txtLabel.font.pixelSize: root.iDelHeaderFontSize
                txtValue.font.pixelSize: root.iDelValueFontSize
              }


              Text {
                anchors.fill: parent
                text: m_model[iLeader.rowIndex][leadingHeaders[index]];
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true; font.pointSize: 16
                color: "black"
              }

            }
          }
        }
      }

      Item {
        id: details
        x: 10; width: parent.width-20
        height: 800

        anchors { top: topLayout.bottom;  bottom: parent.bottom;  }
        opacity: iLeader.detailsOpacity

        GridView {
          id: detailsGrid
          anchors.fill: parent
          model: root.detailFields.length
          //model: 16
          boundsBehavior: Flickable.StopAtBounds

          TabBar {
              visible: false

              id: tabBar1

              TabButton {
                  text: "a"
              }

              TabButton {
                  text: "b"
              }
          }

          ComboBox {
              visible: index === 0
              id: comboBox
              width: parent.width
              model: ListModel {
                  id: model
                  ListElement { text: "Normal"; }
                  ListElement { text: "Gradient"; }
              }

              onCurrentIndexChanged: {
                tabBar1.currentIndex = currentIndex
                minorRectangle.state = tabBar1.currentIndex === 0 ? "solidColorState" : "gradientColorState";
                mainRectangle.state = tabBar1.currentIndex === 0 ? "solidColorState" : "gradientColorState";
              }

              background: Rectangle {
                  color: "#868A01"
                  radius: 4
              }
          }

          StackLayout {
              id: stackLayout
              currentIndex: tabBar1.currentIndex

              anchors {
                  left: parent.left
                  right: parent.right
                  top: parent.top
                  topMargin: 40
                  bottom: parent.bottom
              }

              Item {
                  id: firstItem
                  anchors.fill: parent

                  TextField {
                      visible: index === 0
                      id: textField
                      text: ""
                      width: parent.width
                      height: 25

                      anchors {
                          top: comboBox.bottom
                          topMargin: 10
                          left: parent.left
                          right: colorRec.left
                          rightMargin: 10
                      }
                  }

                  Rectangle {
                      visible: index === 0
                      id: colorRec
                      width: 20
                      height: 20
                      color: "white"
                      radius: 4


                      anchors {
                          top: comboBox.bottom
                          topMargin: 12.5
                          left: parent.left
                          leftMargin: 310
                      }

                      MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              colorDialog.visible = true
                          }
                      }
                  }

                  ColorDialog {
                      visible: false
                      id: colorDialog
                      title: "Please choose a color"
                      onAccepted: {
                          console.log("You chose: " + colorDialog.color)
                          mainRectangle.color = colorDialog.color
                          colorRec.color = colorDialog.color
                          textField.text = colorDialog.color
                      }
                      onRejected: {
                          console.log("Canceled")
                          Qt.quit()
                      }
                      Component.onCompleted: visible = false
                  }

                  TextField {
                      visible: index === 0
                      id: textFieldMinor
                      text: ""
                      width: parent.width
                      height: 25

                      anchors {
                          top: textField.bottom
                          topMargin: 10
                          left: parent.left
                          right: colorRec.left
                          rightMargin: 10
                      }
                  }

                  Rectangle {
                      visible: index === 0
                      id: colorRecMinor
                      width: 20
                      height: 20
                      color: "white"
                      radius: 4


                      anchors {
                          top: textField.bottom
                          topMargin: 12.5
                          left: parent.left
                          leftMargin: 310
                      }

                      MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              colorDialogMinor.visible = true
                          }
                      }
                  }

                  ColorDialog {
                      visible: index === 0
                      id: colorDialogMinor
                      title: "Please choose a color"
                      onAccepted: {
                          console.log("You chose: " + colorDialogMinor.color)
                          minorRectangle.color = colorDialogMinor.color
                          colorRecMinor.color = colorDialogMinor.color
                          textFieldMinor.text = colorDialogMinor.color
                      }
                      onRejected: {
                          console.log("Canceled")
                          Qt.quit()
                      }
                      Component.onCompleted: visible = false
                  }
              }

              Item {
                  id: secondItem

                  GradientPicker {
                      id: gradientPicker
                  }

              }
          }

          SpinBox {
              visible: index === 0
              id: spinBoxPadding
              value: 0
              width: parent.width
              height: 25

              anchors {
                  left: parent.left
                  right: parent.right
                  top: parent.top
                  topMargin: 110
              }


              onValueChanged: {
                  mainRectangle.anchors.margins = spinBoxPadding.value;
              }
          }

          SpinBox {
              visible: index === 0
              id: spinBoxMargins
              value: 0
              width: parent.width
              height: 25

              anchors {
                  top: spinBoxPadding.bottom
                  topMargin: 10
                  left: parent.left
              }

              onValueChanged: {
                  minorRectangle.anchors.margins = spinBoxMargins.value;
              }
          }

          Slider {
              visible: index === 0
              id: controlBorder
              stepSize: 1
              from: 0
              to: 100
              value: 0

              handle: Rectangle {
                  x: controlBorder.leftPadding + controlBorder.visualPosition * (controlBorder.availableWidth - width)
                  y: controlBorder.topPadding + controlBorder.availableHeight / 2 - height / 2
                  implicitWidth: 26
                  implicitHeight: 26
                  radius: 13
                  color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                  border.color: "#bdbebf"
                  Label {
                      anchors.centerIn: parent
                      text: Number(controlBorder.value).toFixed()
                  }
              }

              anchors {
                  top: spinBoxMargins.bottom
                  topMargin: 10
                  left: parent.left
                  right: parent.right
              }

              onValueChanged: {
                mainRectangle.border.width = controlBorder.value
              }

              background: Rectangle {
                  x: controlBorder.leftPadding
                  y: controlBorder.topPadding + controlBorder.availableHeight / 2 - height / 2
                  implicitHeight: 4
                  width: controlBorder.availableWidth
                  height: implicitHeight
                  radius: 13
                  color: "#868A01"
              }
          }

          SpinBox {
              visible: index === 0
              id: spinBoxRadius
              value: 0
              width: parent.width
              height: 25

              anchors {
                  top: controlBorder.bottom
                  topMargin: 10
                  left: parent.left
                  right: parent.right
              }

              onValueChanged: {
                  mainRectangle.radius = spinBoxRadius.value;
              }
          }
                    ComboBox {
                        visible: index === 1
                        //z: 1
                        id: comboBoxText
                        width: parent.width
                        model: ListModel {
                            id: modelText
                            ListElement { text: "No"; }
                            ListElement { text: "Yes"; }
                        }

                        background: Rectangle {
                            color: "#868A01"
                            radius: 4
                        }

                        Binding {
                            target: topRect
                            property: "visible"
                            value: comboBoxText.currentText === "Yes"
                        }
                    }

                    Slider {
                        visible: index === 1
                        id: control
                        stepSize: 1
                        from: 0
                        to: 100
                        value: 0

                        handle: Rectangle {
                            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                            y: control.topPadding + control.availableHeight / 2 - height / 2
                            implicitWidth: 26
                            implicitHeight: 26
                            radius: 13
                            color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                            border.color: "#bdbebf"
                            Label {
                                anchors.centerIn: parent
                                text: Number(control.value).toFixed()
                            }
                        }

                        anchors {
                            top: comboBoxText.bottom
                            topMargin: 10
                            left: parent.left
                            right: parent.right
                        }

                        onValueChanged: {
                            topRectText.font.pixelSize = control.value
                        }

                        background: Rectangle {
                            x: control.leftPadding
                            y: control.topPadding + control.availableHeight / 2 - height / 2
                            implicitHeight: 4
                            width: control.availableWidth
                            height: implicitHeight
                            radius: 13
                            color: "#868A01"
                        }
                    }


                    TextField {
                        visible: index === 1
                        id: textFieldText
                        text: ""
                        width: parent.width
                        height: 25

                        anchors {
                            top: control.bottom
                            topMargin: 10
                            left: parent.left
                            right: colorRecText.left
                            rightMargin: 10
                        }
                    }

                    Rectangle {
                        visible: index === 1
                        id: colorRecText
                        //z: 1
                        width: 20
                        height: 20
                        color: "white"
                        radius: 4

                        anchors {
                            top: control.bottom
                            topMargin: 12.5
                            left: parent.left
                            leftMargin: 310
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                colorDialogText.visible = true
                            }
                        }
                    }

                    ColorDialog {
                        visible: index === 1
                        //visible: false
                        id: colorDialogText
                        title: "Please choose a color"
                        onAccepted: {
                            topRectText.color = colorDialogText.color
                            textFieldText.text = colorDialogText.color
                            colorRecText.color = colorDialogText.color
                        }
                        onRejected: {
                            console.log("Canceled")
                            Qt.quit()
                        }
                        Component.onCompleted: visible = false
                    }

                    TextInput {
                        visible: index === 1
                        id: textInputTop
                        text: "Height: "
                        color: "white"
                        font.pixelSize: 16
                        anchors {
                            top: colorRecText.bottom
                            topMargin: 20
                            left: parent.left
                            right: parent.right
                        }

                        onTextChanged: {
                            var inputHeight = parseInt(text.substring(text.indexOf(":") + 1))
                            if (!isNaN(inputHeight)) {
                                topRect.height = inputHeight
                            }
                        }
                    }

                    ComboBox {
                                  visible: index === 2
                                  id: comboBoxBottom
                                  width: parent.width
                                  model: ListModel {
                                      id: modelTextBottom
                                      ListElement { text: "No"; }
                                      ListElement { text: "Yes"; }
                                  }

                                  background: Rectangle {
                                      color: "#868A01"
                                      radius: 4
                                  }

                                  Binding {
                                      target: bottomRect
                                      property: "visible"
                                      value: comboBoxBottom.currentText === "Yes"
                                  }
                              }

                              Slider {
                                  visible: index === 2
                                  id: controlBottom
                                  stepSize: 1
                                  from: 0
                                  to: 100
                                  value: 0

                                  handle: Rectangle {
                                      x: controlBottom.leftPadding + controlBottom.visualPosition * (controlBottom.availableWidth - width)
                                      y: controlBottom.topPadding + controlBottom.availableHeight / 2 - height / 2
                                      implicitWidth: 26
                                      implicitHeight: 26
                                      radius: 13
                                      color: controlBottom.pressed ? "#f0f0f0" : "#f6f6f6"
                                      border.color: "#bdbebf"
                                      Label {
                                          anchors.centerIn: parent
                                          text: Number(controlBottom.value).toFixed()
                                      }
                                  }

                                  anchors {
                                      top: comboBoxBottom.bottom
                                      topMargin: 10
                                      left: parent.left
                                      right: parent.right
                                  }

                                  onValueChanged: {
                                      bottomRectText.font.pixelSize = controlBottom.value
                                  }

                                  background: Rectangle {
                                      x: controlBottom.leftPadding
                                      y: controlBottom.topPadding + controlBottom.availableHeight / 2 - height / 2
                                      implicitHeight: 4
                                      width: controlBottom.availableWidth
                                      height: implicitHeight
                                      radius: 13
                                      color: "#868A01"
                                  }
                              }


                              TextField {
                                  visible: index === 2
                                  id: textFieldBottom
                                  text: ""
                                  width: parent.width
                                  height: 25

                                  anchors {
                                      top: controlBottom.bottom
                                      topMargin: 10
                                      left: parent.left
                                      right: colorRecBottom.left
                                      rightMargin: 10
                                  }
                              }

                              Rectangle {
                                  visible: index === 2
                                  id: colorRecBottom
                                  width: 20
                                  height: 20
                                  color: "white"
                                  radius: 4


                                  anchors {
                                      top: controlBottom.bottom
                                      topMargin: 12.5
                                      left: parent.left
                                      leftMargin: 310
                                  }

                                  MouseArea {
                                      anchors.fill: parent
                                      onClicked: {
                                          colorDialogBottom.visible = true
                                      }
                                  }
                              }

                              ColorDialog {
                                  visible: index === 2
                                  id: colorDialogBottom
                                  title: "Please choose a color"
                                  onAccepted: {
                                      bottomRectText.color = colorDialogBottom.color
                                      textFieldBottom.text = colorDialogBottom.color
                                      colorRecBottom.color = colorDialogBottom.color
                                  }
                                  onRejected: {
                                      console.log("Canceled")
                                      Qt.quit()
                                  }
                                  Component.onCompleted: visible = false
                              }

                              InnerCenterRect {
                                  visible: index === 3
                                  width: parent.width/1.3
                                  height: parent.height
                              }





          MouseArea {
            id: maDetails
            enabled: maDetailsEnabled
            anchors.fill: parent
            onClicked: {
              maRow.onClicked(null)
            }
            onPressAndHold:  {
              rowPressAndHold(index);
            }
          }

          onEnabledChanged: {
            if(enabled)
              root.detailGridHeight = contentHeight;
          }

          clip: true
          cellWidth: iDelWidth
          cellHeight: iDelHeight


          delegate: DetailDelegate {
            id: detailDelegate
            width: detailsGrid.cellWidth
            height: detailsGrid.cellHeight
            label: root.detailFields[index]
            value: m_model[iLeader.rowIndex][root.detailFields[index]];

            txtValue.font.pixelSize: root.iDelValueFontSize
            txtLabel.font.pixelSize: root.iDelHeaderFontSize

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: root.cellEntered(index, detailDelegate.label)
              onExited:  root.cellExited(index, detailDelegate.label)
            }
          }
        }
      }

      states: State {
        name: "Details"
        when: expandedRows.includes(iLeader.rowIndex);

        PropertyChanges {
          target: background;
          color: Qt.lighter(baseColor, 2.5);
          border.width: 3
        }
        PropertyChanges {
          target: iLeader;
          detailsOpacity: 1
          x: 0
          height: {
            return detailsGrid.contentHeight + iDelHeight + 25 + 240
          }
        }
        PropertyChanges {
          target: detailsGrid;
          enabled: true
          model: root.detailFields
        }
      }

      transitions: Transition {
        ParallelAnimation {
          ColorAnimation { property: "color"; duration: 500 }
          NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
      }
    }
  }

  Item {
    id: iHeader
    height: 0
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    Rectangle {
      anchors.fill: parent
      color: Qt.darker(baseColor, 1.25)
    }
  }

  ListView {
    id: listView
    anchors.top: iHeader.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.topMargin: 5

    model: m_model.length
    delegate: recipeDelegate

    ScrollBar.vertical: ScrollBar {
      active: true
    }
  }

  function setExplicitModel(model) {
    m_model = model.getJson();
  }

  function setBasicModel(data) {
    m_model = data;
    expandedRows = [];
  }

  function fieldByName(fieldName, rowIndex) {
    return m_model[rowIndex][fieldName];
  }
}
