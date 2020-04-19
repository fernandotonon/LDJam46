import QtQuick 2.14
import QtMultimedia 5.14

Image{
    id:cavaleiro
    height: castelo.height*0.1
    source:"qrc:///imagens/cavaleiro.png"
    fillMode: Image.PreserveAspectFit
    x:-100000

    property int maxVida: 10
    property real vida: maxVida

    property var alvo;

    property bool pegandoFogo: janela.dragao.fogo
                               &&Math.abs(janela.dragao.x+(janela.dragao.viradoDireita?janela.dragao.width:0)-x)<width*0.9
                               &&Math.abs(janela.dragao.y-y-parent.y)<janela.dragao.height*2

    Component.onCompleted: {
        timerRevive.start()
    }

    function restart(){
        alvo=null
        x=-100000
        timerRevive.start()
    }

    onAlvoChanged: {
        if(alvo)
            timerAtaca.start()
        else{
            lanca.x=lanca.parent.width*0.4
            lanca.y=lanca.parent.height*0.25
        }
    }

    onVidaChanged: {
        if(vida<=0){
            x=-100000
            alvo=null
            timerRevive.start()
        }
    }
    Timer{
        id:timerRevive
        interval: Math.random()*10000
        running: false
        onTriggered: revive()
    }
    function revive(){
        x=-width
        vida=maxVida
        fogo.visible=false
        timerRevive.interval=Math.random()*10000
    }

    Lanca{
        id:lanca
        x:parent.width*0.4
        y:parent.height*0.25
        NumberAnimation on x{
            id:lXAnim
            running: false
            alwaysRunToEnd: true
            duration:700
            easing.type: Easing.OutExpo
        }
        NumberAnimation on y{
            id:lYAnim
            running: false
            alwaysRunToEnd: true
            duration:500
            easing.type: Easing.OutExpo
            onFinished: {
                            lanca.x=lanca.parent.width*0.4
                            lanca.y=lanca.parent.height*0.25
                            if(alvo)
                                alvo.dano()
                        }
        }
    }
    Timer{
        id:timerAtaca
        interval: Math.random()*500
        running: false
        onTriggered: ataca()
    }

    function ataca(){
        if(alvo&&!janela.gameover){
            lXAnim.to=cavaleiro.mapFromItem(alvo,alvo.width/2,0).x-lanca.width/2
            lXAnim.start()
            lYAnim.to=cavaleiro.mapFromItem(alvo,0,0).y+alvo.height/2
            lYAnim.start()
        }
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

    SoundEffect{
        id: pocotoSFX
        volume: 0.01
        source: "qrc:///SFX/pocoto.wav"
    }

    function anda(){

        if(Math.abs(cavaleiro.mapFromItem(janela.dragao,0,0).x)<width*2&&
                Math.abs(cavaleiro.mapFromItem(janela.dragao,0,0).y)<height)
            alvo = janela.dragao
        else if(x>=janela.width-castelo.width)
            alvo=janela.princesa
        else
            alvo = null

        if(!alvo){
            x+=10
            lanca.rotation=0
            if(!pocotoSFX.playing&&x>0)
                pocotoSFX.play()
        }else{
            lanca.rotation = Math.atan(cavaleiro.mapFromItem(janela.dragao,0,0).y/cavaleiro.mapFromItem(janela.dragao,0,0).x)*180/Math.PI
        }

        vida-=fogo.visible&&vida>0?1:0
        vida-=pegandoFogo&&vida>0?1:0
    }
}
