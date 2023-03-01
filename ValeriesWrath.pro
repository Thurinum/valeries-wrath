QT += quick qml

CONFIG += c++20

SOURCES = $$files("src/*.cpp", true)
HEADERS = $$files("include/*.hpp", true)
INCLUDEPATH += include

resources.files = $$files("$$PWD/resources/*", true)
resources.prefix = /
RESOURCES += resources

DESTDIR = $$PWD/bin
