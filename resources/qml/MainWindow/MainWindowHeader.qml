// Copyright (c) 2018 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1

import UM 1.4 as UM
import Cura 1.0 as Cura

import "../Account"

Rectangle
{
    id: base

    implicitHeight: UM.Theme.getSize("main_window_header").height
    implicitWidth: UM.Theme.getSize("main_window_header").width
    color: UM.Theme.getColor("main_window_header_background")

    Image
    {
        id: logo
        anchors.left: parent.left
        anchors.leftMargin: UM.Theme.getSize("default_margin").width
        anchors.verticalCenter: parent.verticalCenter

        source: UM.Theme.getImage("logo")
        width: UM.Theme.getSize("logo").width
        height: UM.Theme.getSize("logo").height

        sourceSize.width: width
        sourceSize.height: height
    }

    Row
    {
        id: stagesListContainer
        spacing: Math.round(UM.Theme.getSize("default_margin").width / 2)

        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            leftMargin: UM.Theme.getSize("default_margin").width
        }

        // The main window header is dynamically filled with all available stages
        Repeater
        {
            id: stagesHeader

            model: UM.StageModel { }

            delegate: Button
            {
                text: model.name.toUpperCase()
                checkable: true
                checked: model.active
                anchors.verticalCenter: parent.verticalCenter
                exclusiveGroup: mainWindowHeaderMenuGroup
                style: UM.Theme.styles.main_window_header_tab
                height: Math.round(0.56 * UM.Theme.getSize("main_window_header").height)
                onClicked: UM.Controller.setActiveStage(model.id)
                iconSource: model.stage.iconSource

                property color overlayColor: "transparent"
                property string overlayIconSource: ""
            }
        }

        ExclusiveGroup { id: mainWindowHeaderMenuGroup }
    }

    // Shortcut button to quick access the Toolbox
    Cura.ActionButton
    {
        anchors
        {
            right: accountWidget.left
            rightMargin: UM.Theme.getSize("default_margin").width
            verticalCenter: parent.verticalCenter
        }
        leftPadding: UM.Theme.getSize("default_margin").width
        rightPadding: UM.Theme.getSize("default_margin").width
        text: catalog.i18nc("@action:button", "Toolbox")
        height: Math.round(0.5 * UM.Theme.getSize("main_window_header").height)
        color: UM.Theme.getColor("main_window_header_secondary_button_background_active")
        hoverColor: UM.Theme.getColor("main_window_header_secondary_button_background_hovered")
        outlineColor: UM.Theme.getColor("main_window_header_secondary_button_outline_active")
        outlineHoverColor: UM.Theme.getColor("main_window_header_secondary_button_outline_hovered")
        textColor: UM.Theme.getColor("main_window_header_secondary_button_text_active")
        textHoverColor: UM.Theme.getColor("main_window_header_secondary_button_text_hovered")
        onClicked: Cura.Actions.browsePackages.trigger()
    }

    AccountWidget
    {
        id: accountWidget
        anchors
        {
            right: parent.right
            rightMargin: UM.Theme.getSize("default_margin").width
        }
    }
}