import QtQuick 2.14

Rectangle{
    id:barra
    property real pos:1.0
    property alias posicao:barra.pos
    property string c1:"green"
    property alias cor1:barra.c1
    property string c2:"yellow"
    property alias cor2:barra.c2
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width*0.6
    height: parent.height*0.1
    border.width: +height*0.2
    gradient:Gradient{
                orientation:Gradient.Horizontal
                        GradientStop{
                            color: c1
                            position: 0
                        }
                        GradientStop{
                            color: c2
                            position: pos-0.01
                        }
                        GradientStop{
                            color: "black"
                            position: pos+0.01
                        }
                    }
}
