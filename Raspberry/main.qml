/*
� 2016 Copyright by Jari Heiskanen & Markus Niiranen
email: jari.heiskanen.koulu@gmail.com

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>
*/

import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Window {
    visible: true
    width: 800
    height: 480
    color: "#e9e9e9"

    MouseArea {
        id: mouseArea2
        anchors.fill: parent
        onClicked: {
            // Qt.quit();
        }

        Rectangle {
            id: rectangle1
            x: 0
            y: 0
            width: 800
            height: 69
            color: "#5ccd17"
        }

        Rectangle {
            id: rectangle2
            x: 0
            y: 102
            width: 800
            height: 69
            color: "#5ccd17"

            Text {
                id: title
                x: 367
                y: 24
                text: qsTr("Mittaus")
                font.family: "Tahoma"
                font.pixelSize: 18
            }
        }

        Rectangle {
            id: rectangle3
            x: 0
            y: 411
            width: 800
            height: 69
            color: "#5ccd17"
        }

        Rectangle {
            id: rectangle6
            x: 639
            y: 414
            width: 153
            height: 63
            color: "#e9e9e9"
            radius: 12
            Text {
                id: text_seuraava1
                x: 16
                y: 19
                color: "#6fe726"
                text: qsTr("Seuraava   >")
                font.bold: true
                font.pixelSize: 20
                textFormat: Text.PlainText
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                id: seuraava
                anchors.fill: parent
            }
            border.width: 10
            border.color: "#e9e9e9"
        }

        Rectangle {
            id: rectangle7
            x: 8
            y: 414
            width: 153
            height: 63
            color: "#e9e9e9"
            radius: 12
            Text {
                id: text_edellinen
                x: 17
                y: 19
                color: "#6fe726"
                text: qsTr("<   Edellinen")
                font.bold: true
                font.pixelSize: 20
                textFormat: Text.PlainText
                horizontalAlignment: Text.AlignLeft
            }

            MouseArea {
                id: edellinen
                anchors.fill: parent
            }
            border.width: 10
            border.color: "#e9e9e9"
        }


        //ALASVETOVALIKOT
        Rectangle {
            id:comboBox
            property variant items: ["Helena Hoitaja", "Item 2", "Item 3"]
            property alias selectedItem: chosenItemText.text;
            property alias selectedIndex: listView.currentIndex;
            signal comboClicked;
            x: 8
            y: 20
            width: 138
            height: 30;
            color: "#5ccd17"
            z: 100;
            smooth:true;

            Rectangle {
                id:chosenItem
                radius:0
                border.width: 0
                width:parent.width;
                height:comboBox.height;
                color: "lightsteelblue"
                smooth:true;
                Text {
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.margins: 8;
                    id:chosenItemText
                    text:comboBox.items[0];
                    anchors.leftMargin: 10
                    anchors.topMargin: 5
                    font.family: "Arial"
                    font.pointSize: 14;
                    smooth:true
                }

                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        comboBox.state = comboBox.state==="dropDown"?"":"dropDown"
                    }
                }
            }

            Rectangle {
                id:dropDown
                width:comboBox.width;
                height:0;
                clip:true;
                radius:4;
                anchors.top: chosenItem.bottom;
                anchors.margins: 2;
                color: "lightgray"

                ListView {
                    id:listView
                    height:500;
                    model: comboBox.items
                    currentIndex: 0
                    delegate: Item{
                        width:comboBox.width;
                        height: comboBox.height;

                        Text {
                            text: modelData
                            anchors.top: parent.top;
                            anchors.left: parent.left;
                            anchors.margins: 5;

                        }
                        MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                comboBox.state = ""
                                var prevSelection = chosenItemText.text
                                chosenItemText.text = modelData
                                if(chosenItemText.text != prevSelection){
                                    comboBox.comboClicked();
                                }
                                listView.currentIndex = index;
                            }
                        }
                    }
                }
            }

            Component {
                id: highlight
                Rectangle {
                    width:comboBox.width;
                    height:comboBox.height;
                    color: "red";
                    radius: 4
                }
            }

            states: State {
                name: "dropDown";
                PropertyChanges { target: dropDown; height:30*comboBox.items.length }
            }

            transitions: Transition {
                NumberAnimation { target: dropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 500 }
            }
        }

        Rectangle {
            id: comboBox1
            property variant items: ["Pekka Potilas", "Item 2", "Item 3"]
            property alias selectedItem2: chosenItemText1.text;
            property alias selectedIndex2: listView1.currentIndex;
            signal comboClicked2;
            x: 667
            y: 18
            width: 126
            height: 30
            color: "#5ccd17"
            Rectangle {
                id: chosenItem1
                width: parent.width
                height: comboBox1.height
                color: "#b0c4de"
                radius: 0
                border.width: 0
                Text {
                    id: chosenItemText1
                    text: comboBox1.items[0]
                    anchors.topMargin: 5
                    smooth: true
                    anchors.leftMargin: 10
                    font.family: "Arial"
                    font.pointSize: 14
                    anchors.margins: 8
                    anchors.top: parent.top
                    anchors.left: parent.left
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        comboBox1.state = comboBox1.state==="dropDown"?"":"dropDown"
                    }
                }
                smooth: true
            }

            Rectangle {
                id: dropDown1
                width: comboBox1.width
                height: 0
                color: "#d3d3d3"
                radius: 4
                ListView {
                    id: listView1
                    height: 500
                    currentIndex: 0
                    model: comboBox1.items
                    delegate: Item {
                        width: comboBox1.width
                        height: comboBox1.height
                        Text {
                            text: modelData
                            anchors.margins: 5
                            anchors.top: parent.top
                            anchors.left: parent.left
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                comboBox1.state = ""
                                var prevSelection = chosenItemText1.text
                                chosenItemText1.text = modelData
                                if(chosenItemText1.text != prevSelection){
                                    comboBox1.comboClicked2();
                                }
                                listView1.currentIndex = index;
                            }
                        }
                    }
                }
                clip: true
                anchors.margins: 2
                anchors.top: chosenItem1.bottom
            }

            Component {
                id: highlight1
                Rectangle {
                    width: comboBox1.width
                    height: comboBox1.height
                    color: "#ff0000"
                    radius: 4
                }
            }
            smooth: true
            z: 100
            states: [
                State {
                    name: "dropDown"
                    PropertyChanges {
                        target: dropDown1
                        height: 30*comboBox1.items.length
                    }
                }]
            transitions: [
                Transition {
                    NumberAnimation {
                        target: dropDown1
                        properties: "height"
                        easing.type: Easing.OutExpo
                        duration: 500
                    }
                }]
        }

        //MITTAREITA

        Rectangle {
            id: ylapaine
            x: 47
            y: 209
            width: 75
            height: 75
            color: "#5ccd17"
            radius: 37
            border.width: 0

            Text {
                id: mittari
                x: 23
                y: 30
                width: 29
                height: 16
                color: "#ffffff"
                text: qsTr("0")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 15
            }
        }

        Rectangle {
            id: pulssi
            x: 233
            y: 209
            width: 75
            height: 75
            color: "#5ccd17"
            radius: 37
            Text {
                id: mittari2
                x: 23
                y: 30
                width: 29
                height: 16
                color: "#ffffff"
                text: qsTr("0")
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
            }
            border.width: 0
        }
        CircularGauge {//mittari
            //value: accelerating ? maximumValue : 0
            anchors.centerIn: parent
            id: gauge
            property bool accelerating: false
            width: 182
            height: 160
            z: 102
            anchors.verticalCenterOffset: 49
            anchors.horizontalCenterOffset: 50
            maximumValue: 100
            minimumValue: 0
            value: 0

            style: CircularGaugeStyle {//http://doc.qt.io/qt-5/qml-qtquick-controls-styles-circulargaugestyle.html
                needle: Rectangle {
                    y: outerRadius * 0.15
                    implicitWidth: outerRadius * 0.03
                    implicitHeight: outerRadius * 0.9
                    antialiasing: true
                    color: Qt.rgba(0.66, 0.3, 0, 1)
                }
                background: Rectangle  {
                    color: "#000000"
                    radius: 15
                    border.width: 0
                }
            }

            Behavior on value {//mittarin animaatioita, ettei hyppää kerralla toiseen arvoon
                NumberAnimation {
                    duration: 1000
                }
            }
        }

        Text {
            id: text2
            x: 58
            y: 290
            text: qsTr("Hengitys")
            font.pixelSize: 12
        }

        Text {
            id: text1
            x: 164
            y: 333
            text: qsTr("BPM")
            font.pixelSize: 12
        }

        Text {
            id: text3
            x: 257
            y: 290
            text: qsTr("IBI")
            font.pixelSize: 12
        }

        Image {
            id: image1
            x: 582
            y: 209
            anchors.rightMargin: 73
            anchors.bottomMargin: 205
            anchors.leftMargin: 590
            anchors.topMargin: 205
            anchors.fill: parent
            source: "../../Downloads/Placeholder_Nappeja/SquareButton_3.png"

            MouseArea {
                id: lue_mittaus
                x: 582
                y: 209
                anchors.fill: parent
                onClicked:
                {
                    if(timeri.running == false)
                    {
                        httpGetAsync(33913, 1, handlerifunktio);//lämpötila
                        httpGetAsync(33913, 2, handlerifunktio);//hengitysilma
                        httpGetAsync(33913, 3, handlerifunktio);//BPM
                        httpGetAsync(33913, 4, handlerifunktio);//IBI
                        timeri.running = true;
                        text_luku.text = "Pysäytä mittaus";
                    }
                    else
                    {
                        timeri.running = false;
                        heartbeat.running = false;
                        text_luku.text = "Aloita mittaus";
                        gauge.value = 0;
                        mittari.text = 0;
                        mittari1.text = 0;
                        mittari2.text = 0;
                    }
                }
            }

            Text {
                id: text_luku
                color: "#ffffff"
                text: qsTr(" Aloita mittaus")
                anchors.leftMargin: 18
                anchors.topMargin: 24
                anchors.rightMargin: 18
                anchors.bottomMargin: 24
                anchors.fill: parent
                z: 3
                textFormat: Text.PlainText
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 15
            }
        }

        Image {
            id: image2
            x: 612
            y: 299
            width: 94
            height: 84
            source: "../../Downloads/Placeholder_Nappeja/Save_Blue.png"

            MouseArea {
                id: mouseArea1
                anchors.fill: parent
                onClicked:
                {
                    Qt.quit();
                }
            }
        }

        Image {
            id: heart
            x: 140
            y: 177
            width: 75
            height: 69
            anchors.verticalCenterOffset: 59
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: -222
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../Downloads/Placeholder_Nappeja/Heart.png"
            //Behavior on width { SmoothedAnimation { velocity: 500 } }
            //Behavior on height { SmoothedAnimation { velocity: 500 } }
            Behavior on width { SpringAnimation { spring: 2; damping: 0.5 } }
            Behavior on height { SpringAnimation { spring: 2; damping: 0.5 } }

            Text {
                id: mittari1
                x: 23
                y: 25
                width: 29
                height: 16
                color: "#ffffff"
                text: qsTr("0")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

    }
    Item {
        Timer {//timeri sekunnin välein
            id: timeri
            interval: 2500;
            running: false;
            repeat: true;
            onTriggered:
            {
                //haetaan thingspeakin kentät
                //gauge.value = receiver.onSendToQml(1)
                //mittari.text = receiver.onSendToQml(2)

                httpGetAsync(33913, 1, handlerifunktio);//lämpötila
                httpGetAsync(33913, 2, handlerifunktio);//hengitysilma
                httpGetAsync(33913, 3, handlerifunktio);//BPM
                httpGetAsync(33913, 4, handlerifunktio);//IBI
                //mittari1.text = receiver.onSendToQml(3)
                //mittari2.text = receiver.onSendToQml(4)
            }
        }
        Timer {//timeri sekunnin välein
            id: heartbeat
            interval: 1000;
            running: false;
            repeat: true;
            onTriggered:
            {
                heart.width = heart.width*1.5;
                heart.height = heart.height*1.5;

                heartbeat2.running = true;
            }
        }
        Timer {
            id: heartbeat2
            interval: 100;
            running: false;
            repeat: true;
            onTriggered:
            {
                heart.width = 75;
                heart.height = 69;
                heartbeat2.running = false;
            }

        }
    }
    function httpGetAsync(channel, field, callback)
    {
        var address = "http://api.thingspeak.com/channels/"+channel+"/field/"+field+"/last";
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
                callback(xmlHttp.responseText, field);
        }
        xmlHttp.open("GET", address, true); // true for asynchronous
        xmlHttp.send(null);
    }
    function handlerifunktio(response, channel)
    {
        switch(channel)
        {
        case 1:
            gauge.value = Math.floor(response);
            break;
        case 2:
            mittari.text = Math.floor(response);
            break;
        case 3:
            mittari1.text = Math.floor(response);
            heartbeat.running = true;
            heartbeat.interval = 1000/(response/60);
            break;
        case 4:
            mittari2.text = Math.floor(response);
            break;
        default:
            console.log("valitse kanava väliltä 1-4");
            break;
        }

    }
}

