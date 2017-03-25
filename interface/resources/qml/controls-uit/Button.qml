//
//  Button.qml
//
//  Created by David Rowe on 16 Feb 2016
//  Copyright 2016 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//

import QtQuick 2.5
import QtQuick.Controls 1.4 as Original
import QtQuick.Controls.Styles 1.4

import "../styles-uit"

Original.Button {
    property int color: 0
    property int colorScheme: hifi.colorSchemes.light

    width: 120
    height: hifi.dimensions.controlLineHeight

    HifiConstants { id: hifi }

    // FIXME: THIS WORKAROUND MIGRATED/CONSOLIDATED FROM RUNNINGSCRIPTS.QML

    // For some reason trigginer an API that enters
    // an internal event loop directly from the button clicked
    // trigger below causes the appliction to behave oddly.
    // Most likely because the button onClicked handling is never
    // completed until the function returns.
    // FIXME find a better way of handling the input dialogs that
    // doesn't trigger this.

    // NOTE: dialogs that need to use this workaround can connect via
    //    onQueuedClicked: ...
    // instead of:
    //    onClicked: ...

    onClicked: fromTimer.running = true
    signal queuedClicked()
    Timer {
        id: fromTimer
        interval: 5
        repeat: false
        running: false
        onTriggered: { console.info('onQueuedClicked->onTriggered'); queuedClicked() }
    }
    onQueuedClicked: console.info('HifiControls.Button -- please define onClicked: or onQueuedClicked:')

    style: ButtonStyle {
        background: Rectangle {
            radius: hifi.buttons.radius

            gradient: Gradient {
                GradientStop {
                    position: 0.2
                    color: {
                        if (!control.enabled) {
                            hifi.buttons.disabledColorStart[control.colorScheme]
                        } else if (control.pressed) {
                            hifi.buttons.pressedColor[control.color]
                        } else if (control.hovered) {
                            hifi.buttons.hoveredColor[control.color]
                        } else {
                            hifi.buttons.colorStart[control.color]
                        }
                    }
                }
                GradientStop {
                    position: 1.0
                    color: {
                        if (!control.enabled) {
                            hifi.buttons.disabledColorFinish[control.colorScheme]
                        } else if (control.pressed) {
                            hifi.buttons.pressedColor[control.color]
                        } else if (control.hovered) {
                            hifi.buttons.hoveredColor[control.color]
                        } else {
                            hifi.buttons.colorFinish[control.color]
                        }
                    }
                }
            }
        }

        label: RalewayBold {
            font.capitalization: Font.AllUppercase
            color: enabled ? hifi.buttons.textColor[control.color]
                           : hifi.buttons.disabledTextColor[control.colorScheme]
            size: hifi.fontSizes.buttonLabel
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: control.text
        }
    }
}
