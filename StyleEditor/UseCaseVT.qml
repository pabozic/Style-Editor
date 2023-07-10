mport QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  id: root
  objectName: "root"
  anchors.fill: parent


  CDVerticalTableA {
    anchors.centerIn: parent
    width: 560
    height: 500

    leadingHeaders: ["Name1", "Name3"]
    headerColumnWidths: [width*0.66, width*0.33]
    detailsHeight: 50

    Component.onCompleted: {
      var data = [
            {"Name1" : "Value1", "Name2" : "Value2", "Name3" : "Value3", "Name4" : "Value4", "Name5" : "Value5"},
            {"Name1" : "Value1", "Name2" : "Value2", "Name3" : "Value3", "Name4" : "Value4", "Name5" : "Value5"},
            {"Name1" : "Value1", "Name2" : "Value2", "Name3" : "Value3", "Name4" : "Value4", "Name5" : "Value5"},
          ]

      setBasicModel(data);
    }
  }
}

