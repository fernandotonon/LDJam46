import QtQuick
import QtMultimedia

Item {
    id: dragao
    focus: true
    height: corpo.height
    width: cabeca.width+corpo.width+pernas.width

    property int maxVida: 20
    property int vida: maxVida
    property int maxEnergia: 20
    property real energia: maxVida

    property int altura: castelo.height*0.08
    property int deslocamento: 2
    property bool sobe: false
    property bool desce: false
    property bool esquerda: false
    property bool direita: false
    property bool soltaFogo: false
    property bool virado: false
    property alias fogo: baforada.visible
    property alias viradoDireita: dragao.virado
    property alias cabeca:cabeca

    signal morreu()

    onSoltaFogoChanged: if(soltaFogo) dragaoSFX.play()

    Scale{
        id: mScale
        xScale: -1
    }

    Translate {
        id: mTranslate
        x: dragao.width
    }

    Fogo{
        id:baforada
        visible: soltaFogo&&energia>=1
        width: parent.width/2
        anchors.centerIn: cabeca
        anchors.horizontalCenterOffset:-cabeca.width/2
        anchors.verticalCenterOffset: cabeca.height/2
        angulo: 130
        direcao: 40
    }
    Image{
        id:cabeca
        height: altura
        source: "qrc:///imagens/cabeca.png"
        fillMode: Image.PreserveAspectFit
    }
    Image{
        id:corpo
        anchors.left: cabeca.right
        height: altura
        source: "qrc:///imagens/corpo.png"
        fillMode: Image.PreserveAspectFit
    }
    Image{
        id:asa
        anchors.centerIn: corpo
        anchors.verticalCenterOffset: corpo.height*0.3
        height: altura
        source: "qrc:///imagens/asa.png"
        fillMode: Image.PreserveAspectFit
        transformOrigin: Item.TopLeft
        SequentialAnimation on rotation {
            id:asaAnim
            loops:  Animation.Infinite
            NumberAnimation{
                from: 0
                to: -50
                duration:1000
                easing.type: Easing.SineCurve
            }
        }
    }
    Image{
        id:pernas
        anchors.verticalCenter: corpo.verticalCenter
        anchors.verticalCenterOffset: pernas.height*0.1
        anchors.left: corpo.right
        height: altura*0.8
        source: "qrc:///imagens/pernas.png"
        fillMode: Image.PreserveAspectFit
        rotation: -90
    }
    Keys.onRightPressed: {
        direita = true
        transform = [mScale,mTranslate]
        barras.transform = [mScale,mTranslate]
        virado = true
    }
    Keys.onLeftPressed: {
        esquerda = true
        transform = 0
        barras.transform = 0
        virado = false
    }
    Keys.onDownPressed: desce = true
    Keys.onUpPressed: sobe = true
    Keys.onPressed: {
        switch(event.key){
            case Qt.Key_Space:
            case Qt.Key_A:
                soltaFogo = true;
                break;
        }
        event.accepted = true;
    }

    Keys.onReleased: {
        switch(event.key){
            case Qt.Key_Left:
                esquerda = false;
                break;
            case Qt.Key_Right:
                direita = false;
                break;
            case Qt.Key_Up:
                sobe = false;
                break;
            case Qt.Key_Down:
                desce = false;
                break;
            case Qt.Key_Space:
            case Qt.Key_A:
                soltaFogo = false;
                break;
        }
        event.accepted = true;
    }

    Item{
        id:barras
        anchors.fill: parent
        anchors.topMargin: -20
        Barra{
            posicao: vida/maxVida
        }
        Barra{
            y:height+1
            posicao: energia/maxEnergia
            cor1:"darkred"
            cor2:"red"
        }
    }

    Timer{
        interval: 5
        running: true
        repeat: true
        onTriggered: voa()
    }

    function voa(){
        if(direita){
            x+=x+deslocamento+dragao.width<janela.width?deslocamento:0;
        }
        if(esquerda){
            x-=x-deslocamento>0?deslocamento:0;
        }
        if(sobe){
            y-=y-deslocamento>0?deslocamento:0;
        }
        if(desce){
            y+=y+deslocamento+dragao.height<janela.height?deslocamento:0;
        }
        if(soltaFogo)
            energia-=energia>=1?0.1:0
        else
            energia+=energia<maxEnergia?0.1:0

    }

    NumberAnimation on y{
        id:yAnim
        running: false
        alwaysRunToEnd: true
        duration:500
        easing.type: Easing.OutExpo
        to: janela.height-height
        onFinished: {
            asaAnim.pause()
            morreu()
        }
    }

    SoundEffect{
        id: dragaoSFX
        source: "qrc:///SFX/dragon.wav"
    }

    function dano(){
        vida-=vida>0?1:0
        if(vida<=0){
            enabled = false
            yAnim.start()
        }
    }

    function restart(){
        enabled=true
        focus=true
        yAnim.stop()
        x=0
        y=0
        asaAnim.resume()
        vida=maxVida
    }
}
