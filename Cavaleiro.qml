import QtQuick 2.0

Image{
    height: castelo.height*0.1
    source:"qrc:///imagens/cavaleiro.png"
    fillMode: Image.PreserveAspectFit
    property bool pegandoFogo: janela.dragao.fogo
                               &&Math.abs(janela.dragao.x+(janela.dragao.viradoDireita?janela.dragao.width:0)-x)<width*0.9
                               &&Math.abs(janela.dragao.y-y-parent.y)<janela.dragao.height*2
    Timer{
        interval: 200
        running: true
        repeat: true
        onTriggered: anda()
    }

    onPegandoFogoChanged: if(pegandoFogo) fogo.visible = true

    Fogo{
        id:fogo
        visible:false
        anchors.centerIn: parent
        width: parent.width*2
    }

    function anda(){
        if(x<janela.width-castelo.width*0.8){
            x+=10
        }else{
            x=0
            fogo.visible = false
        }
    }
}
