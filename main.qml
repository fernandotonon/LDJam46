import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    id: janela
    visible: true
    width: 640
    height: 480

    property alias dragao:dragao

    Rectangle{
        anchors.fill: parent
        gradient: Gradient{
            GradientStop{
                color: "lightsteelblue"
                position: 0
            }
            GradientStop{
                color: "white"
                position: 1
            }
        }
    }
    Rectangle{
        id: ground
        width: parent.width
        height: parent.height*0.2
        anchors.bottom: parent.bottom
        gradient: Gradient{
            GradientStop{
                color: "lightgreen"
                position: 0
            }
            GradientStop{
                color: "green"
                position: 1
            }
        }

        Cavaleiro{

        }
        Cavaleiro{
            y:height+5
            x:-100

        }
    }
    Image{
        anchors.left:parent.left
        height: castelo.height*0.2
        source: "qrc:///imagens/sol.png"
        fillMode: Image.PreserveAspectFit
    }
    Image{
        id:castelo
        anchors.right:parent.right
        height: parent.height
        source: "qrc:///imagens/castelo.png"
        fillMode: Image.PreserveAspectFit
    }
    Image{
        x:janela.width*0.2
        y:janela.height*0.2
        height: parent.height*0.2
        fillMode: Image.PreserveAspectFit
        source: "qrc:///imagens/nuvem.png"
    }
    Dragao{
        id:dragao
    }
}
