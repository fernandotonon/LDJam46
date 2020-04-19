import QtQuick 2.0

Item {
    id: dragao
    focus: true
    height: corpo.height
    width: cabeca.width+corpo.width+pernas.width

    property int altura: castelo.height*0.1
    property int deslocamento: 2
    property bool sobe: false
    property bool desce: false
    property bool esquerda: false
    property bool direita: false
    property bool soltaFogo: false
    property bool virado: false
    property alias fogo: dragao.soltaFogo
    property alias viradoDireita: dragao.virado
    property alias cabeca:cabeca

    Scale{
        id: mScale
        xScale: -1
    }

    Translate {
        id: mTranslate
        x: dragao.width
    }

    Fogo{
        visible: soltaFogo
        width: parent.width/2
        y:-height*0.4
        x:-cabeca.width+cabeca.width*0.3
        angulo: 110
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
        virado = true
    }
    Keys.onLeftPressed: {
        esquerda = true
        transform = 0
        virado = false
    }
    Keys.onDownPressed: desce = true
    Keys.onUpPressed: sobe = true
    Keys.onPressed: {
        switch(event.key){
            case Qt.Key_Space:
                soltaFogo = true;
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
                soltaFogo = false;
            case Qt.Key_A:
                soltaFogo = false;
                break;
        }
        event.accepted = true;
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
    }
}
