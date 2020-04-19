import QtQuick 2.14

Image{
    height: janela.height*0.1
    fillMode: Image.PreserveAspectFit
    source: "qrc:///imagens/princesa.png"

    property int maxVida: 10
    property int vida: maxVida

    Barra{
        y:-height-1
        posicao: vida/maxVida
    }

    function dano(){
        vida-=vida>0?1:0
    }
}
