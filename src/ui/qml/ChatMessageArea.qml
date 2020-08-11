import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Rectangle {
    id: scroll
    clip: true
    color: "#121212" //CHAT BACKGROUND DARK MODE

    property alias model: messageView.model


    Rectangle {
        id: scrollBar
        width: 5
        height: messageView.visibleArea.heightRatio * (messageView.height - 10)
        y: 5 + messageView.visibleArea.yPosition * (messageView.height - 10)
        x: parent.width - width - 3
        z: 1000
        visible: messageView.visibleArea.heightRatio < 1
        color: "#bbbbbb" //SCROLLBAR????
        radius: 14
    }

    ListView {
        id: messageView
        spacing: 12
        pixelAligned: true
        boundsBehavior: Flickable.StopAtBounds
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            onWheel: {
                wheel.accepted = true
                if (wheel.pixelDelta.y !== 0) {
                    messageView.contentY = Math.max(messageView.originY, Math.min(messageView.originY + messageView.contentHeight - messageView.height, messageView.contentY - wheel.pixelDelta.y))
                } else if (wheel.angleDelta.y !== 0) {
                    messageView.flick(0, wheel.angleDelta.y * 5)
                }
            }
        }

        header: Item { width: 1; height: messageView.spacing }
        footer: Item { width: 1; height: messageView.spacing }
        delegate: MessageDelegate { }

        verticalLayoutDirection: ListView.BottomToTop
    }
}

