import QtQuick 2.0

Image{
    height: castelo.height*0.1
    source:"qrc:///imagens/cavaleiro.png"
    fillMode: Image.PreserveAspectFit
    Timer{
        interval: 200
        running: true
        repeat: true
        onTriggered: anda()
    }

    function anda(){
        if(x<janela.width-castelo.width*0.8){
            x+=10
        }
    }
}
