#include "backend.hpp"

Backend::Backend(QObject *parent) {}

void Backend::blah()
{
    qDebug() << "awooo";
}

QString Backend::name()
{
    return m_name;
}

void Backend::setName(const QString &name)
{
    m_name = name + " owo";
}
