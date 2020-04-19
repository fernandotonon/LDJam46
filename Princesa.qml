import QtQuick 2.14
import QtMultimedia 5.14

Image{
    height: janela.height*0.1
    fillMode: Image.PreserveAspectFit
    source: "qrc:///imagens/princesa.png"

    property int maxVida: 10
    property int vida: maxVida
    property int initialY:0

    signal morreu()

    Component.onCompleted: initialY = y

    function restart(){
        rAnim.stop()
        vida=maxVida
        rotation=0
        y=initialY
    }

    Barra{
        y:-height-1
        posicao: vida/maxVida
    }

    NumberAnimation on rotation{
        id:rAnim
        running: false
        alwaysRunToEnd: true
        duration:200
        to: -270
    }

    NumberAnimation on y{
        id:yAnim
        running: false
        alwaysRunToEnd: true
        duration:500
        easing.type: Easing.OutExpo
        to: janela.height-height
        onFinished: {
            morreu()
        }
    }

    SoundEffect{
        id: helpSFX
        source: "qrc:///SFX/princessHelp.wav"
    }

    Text{
        anchors.horizontalCenter: parent.horizontalCenter
        y:-height-8
        text:"Help!"
        opacity: 0
        color:"purple"
        font.bold:true
        NumberAnimation on opacity{
            id:helpAnim
            from: 1.0
            to: 0.0
            duration: 1000
        }
    }

    function dano(){
        if(!helpSFX.playing){
            helpSFX.play()
            helpAnim.start()
        }
        vida-=vida>0?1:0
        if(vida<=0){
            enabled = false
            yAnim.start()
            rAnim.start()
        }
    }
}
