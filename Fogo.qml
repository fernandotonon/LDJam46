import QtQuick
import QtQuick.Particles

Item {
    id: fireparticles

    width: 200
    height: 480
    property int anguloFogo: 270
    property alias angulo: fireparticles.anguloFogo
    property int direcaoFogo: -40
    property alias direcao: fireparticles.direcaoFogo

    ParticleSystem {
        id: firesystem
        anchors.fill: parent

        Turbulence {
            id: turb
            enabled: true
            x: width/4
            height: parent.height
            width: parent.width
            anchors.fill: parent
            strength: 4
            NumberAnimation on strength{from: 2; to: 8; easing.type: Easing.InOutBounce; duration: 1800; loops: -1}
        }

        ImageParticle {
            groups: ["smoke"]
            source: "qrc:///particleresources/glowdot.png"
            color: "#11111111"
            colorVariation: 0
        }

        ImageParticle {
            groups: ["flame"]
            source: "qrc:///particleresources/glowdot.png"
            color: "#ffff400f"
            colorVariation: 0.1
        }

        ImageParticle {
            groups: ["flame2"]
            source: "qrc:///particleresources/glowdot.png"
            color: "#11ff400f"
            colorVariation: 0.1
        }

        Emitter {
            anchors.centerIn: parent
            group: "flame"

            emitRate: 240
            lifeSpan: 1200
            size: (parent.width/5)
            endSize: (parent.width/5)/2
            sizeVariation: 10
            acceleration: PointDirection { y: direcaoFogo }
            velocity: AngleDirection { angle: anguloFogo; magnitude: 20; angleVariation: 22; magnitudeVariation: 50 }
        }

        Emitter {
            anchors.centerIn: parent
            group: "flame2"

            emitRate: 120
            lifeSpan: 1200
            size: (parent.width/5)
            endSize: (parent.width/5)/2
            sizeVariation: 10
            acceleration: PointDirection { y: direcaoFogo }
            velocity: AngleDirection { angle: anguloFogo; magnitude: 20; angleVariation: 22; magnitudeVariation: 50 }
        }

        TrailEmitter {
            id: smoke1
            width: fireparticles.width
            height: fireparticles.height/2
            group: "smoke"
            follow: "flame2"

            emitRatePerParticle: 1
            lifeSpan: 2400
            lifeSpanVariation: 400
            size: (parent.width/5)/2
            endSize: (parent.width/5)/3
            sizeVariation: 8
            acceleration: PointDirection { y: -40 }
            velocity: AngleDirection { angle: 270; magnitude: 40; angleVariation: 22; magnitudeVariation: 5 }
        }

        TrailEmitter {
            id: smoke2
            width: fireparticles.width
            height: fireparticles.height/2 - 20
            group: "smoke"
            follow: "flame2"

            emitRatePerParticle: 4
            lifeSpan: 2400
            size: (parent.width/5)
            endSize: (parent.width/5)/2
            sizeVariation: 12
            acceleration: PointDirection { y: -40 }
            velocity: AngleDirection { angle: 270; magnitude: 40; angleVariation: 22; magnitudeVariation: 5 }
        }
    }
}
