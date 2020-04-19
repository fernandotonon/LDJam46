import QtQuick 2.14

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

    function dano(){
        vida-=vida>0?1:0
        if(vida<=0){
            enabled = false
            yAnim.start()
            rAnim.start()
        }
    }
}
