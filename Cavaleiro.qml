import QtQuick 2.14

Image{
    height: castelo.height*0.1
    source:"qrc:///imagens/cavaleiro.png"
    fillMode: Image.PreserveAspectFit
    x:-100000

    property int maxVida: 10
    property real vida: maxVida

    property bool pegandoFogo: janela.dragao.fogo
                               &&Math.abs(janela.dragao.x+(janela.dragao.viradoDireita?janela.dragao.width:0)-x)<width*0.9
                               &&Math.abs(janela.dragao.y-y-parent.y)<janela.dragao.height*2

    Component.onCompleted: {
        timerRevive.start()
    }

    onVidaChanged: {
        if(vida<=0){
            x=-100000
            timerRevive.start()
        }
    }
    Timer{
        id:timerRevive
        interval: Math.random()*5000
        running: false
        onTriggered: revive()
    }
    function revive(){
        x=-width
        vida=maxVida
        fogo.visible=false
        timerRevive.interval=Math.random()*5000
    }

    Timer{
        interval: 200
        running: true
        repeat: true
        onTriggered: anda()
    }
    Timer{
        id:timerFogo
        interval: 600
        running: false
        onTriggered: fogo.visible=false
    }

    onPegandoFogoChanged: {
        if(pegandoFogo) fogo.visible = true
        else timerFogo.start()
    }

    Fogo{
        id:fogo
        visible:false
        anchors.centerIn: parent
        width: parent.width*2
    }

    Barra{
        posicao: vida/maxVida
    }

    function anda(){
        if(x<janela.width-castelo.width*0.8){
            x+=10
        }else{
            x=0
            fogo.visible = false
        }
        vida-=fogo.visible&&vida>0?1:0
        vida-=pegandoFogo&&vida>0?0.5:0
    }
}
