import QtQuick
import QtQuick.Window

Window {
    visible: true
    width: 640
    height: 480

    Rectangle{
        id: janela
        anchors.fill: parent
        property alias dragao:dragao
        property alias princesa:princesa
        property alias gameover: goText.visible
        property int timeToRestart: 5

        Rectangle{
            anchors.fill: parent
            color: "lightblue"
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
            color: "lightgreen"
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
                id:c1
            }
            Cavaleiro{
                id:c2
                y:height/2+1
            }
            Cavaleiro{
                id:c3
                y:height+5
            }
        }
        Image{
            anchors.left:parent.left
            height: parent.height*0.2
            source: "qrc:///imagens/sol.png"
            fillMode: Image.PreserveAspectFit
        }
        Image{
            id:castelo
            anchors.right:parent.right
            height: parent.height
            source: "qrc:///imagens/castelo.png"
            fillMode: Image.PreserveAspectFit
            Princesa{
                id:princesa
                x:castelo.width*0.32
                y:castelo.height*0.31
                onMorreu: janela.gameOver()
            }
        }
        Image{
            x:parent.width*0.2
            y:parent.height*0.2
            height: parent.height*0.2
            fillMode: Image.PreserveAspectFit
            source: "qrc:///imagens/nuvem.png"
            NumberAnimation on x{
                to: parent.width
                duration: 9999999
            }
        }
        Dragao{
            id:dragao
            focus: true
            onMorreu: janela.gameOver()
        }

        Text{
            id:goText
            text:"Game Over \n "+parent.timeToRestart
            anchors.centerIn: parent
            font.bold: true
            font.pixelSize: parent.height*0.1
            color: "gold"
            style: Text.Outline
            styleColor: "yellow"
            horizontalAlignment: Text.Center
            visible: false
        }
        Timer{
                id:timerRestart
                interval: 1000
                running: false
                repeat: true
                onTriggered: parent.timeToRestart--
            }
        onTimeToRestartChanged: if(timeToRestart==0) {
                                        timerRestart.stop()
                                        timeToRestart=5
                                        restart()
                                    }

        function gameOver(){
            if(!goText.visible){
                goText.visible = true
                timerRestart.start()
            }
        }
        function restart(){
            c1.restart()
            c2.restart()
            c3.restart()
            timerRestart.stop()
            dragao.restart()
            princesa.restart()
            goText.visible=false
        }
    }
}
