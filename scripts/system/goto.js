"use strict";

//
//  goto.js
//  scripts/system/
//
//  Created by Howard Stearns on 2 Jun 2016
//  Copyright 2016 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//
/* globals Tablet, Toolbars, Script, HMD, DialogsManager */

(function() { // BEGIN LOCAL_SCOPE

var button;
var buttonName = "GOTO";
var toolBar = null;
var tablet = null;

function onAddressBarShown(visible) {
    button.editProperties({isActive: visible});
}

function onClicked(){
    DialogsManager.toggleAddressBar();
}

if (Settings.getValue("HUDUIEnabled")) {
    toolBar = Toolbars.getToolbar("com.highfidelity.interface.toolbar.system");
    button = toolBar.addButton({
        objectName: buttonName,
        imageURL: Script.resolvePath("assets/images/tools/directory.svg"),
        visible: true,
        buttonState: 1,
        defaultState: 1,
        hoverState: 3,
        alpha: 0.9
    });
} else {
    tablet = Tablet.getTablet("com.highfidelity.interface.tablet.system");
    button = tablet.addButton({
        icon: "icons/tablet-icons/goto-i.svg",
        text: buttonName
    });
}

button.clicked.connect(onClicked);
DialogsManager.addressBarShown.connect(onAddressBarShown);

Script.scriptEnding.connect(function () {
    button.clicked.disconnect(onClicked);
    if (tablet) {
        tablet.removeButton(button);
    }
    if (toolBar) {
        toolBar.removeButton(buttonName);
    }
    DialogsManager.addressBarShown.disconnect(onAddressBarShown);
});

}()); // END LOCAL_SCOPE
