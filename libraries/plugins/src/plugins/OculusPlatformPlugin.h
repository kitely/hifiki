//
//  Created by Wayne Chen on 2018/12/20
//  Copyright 2018 High Fidelity Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2-0.html
//
#pragma once

#include <QObject>
#include <QtCore/QString>

#include <functional>

class OculusPlatformPlugin : public QObject {
    Q_OBJECT
public:
    OculusPlatformPlugin();
    virtual ~OculusPlatformPlugin();

    virtual const QString getName() const = 0;

    virtual void handleOVREvents() = 0;

signals:
    void nonceAndUserIDChanged(QString nonce, QString userID);
};
