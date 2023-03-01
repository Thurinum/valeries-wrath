#ifndef BACKEND_H
#define BACKEND_H

#include <QDebug>
#include <QObject>

class Backend : public QObject
{
    Q_OBJECT

public:
    explicit Backend(QObject *parent = nullptr);

    Q_INVOKABLE void blah();

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

    QString name();
    void setName(const QString &name);

signals:
    void nameChanged(QString name);

private:
    QString m_name;
};

#endif
