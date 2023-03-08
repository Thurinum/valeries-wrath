#include "backend.hpp"
#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>
#include <QUrl>

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	QQuickView view;
	view.setSource(QUrl("qrc:/resources/qml/Main.qml"));

	if (view.rootObject())
		app.exit(1);

	view.setWidth(1280);
	view.setHeight(720);
	view.setTitle("SOLID: Valerie's Wrath");
	view.setIcon(QIcon("qrc:/resources/images/valerie.png"));
	view.setColor(Qt::transparent);
	view.setModality(Qt::WindowModal);
	view.setFlags(Qt::FramelessWindowHint | Qt::CustomizeWindowHint | Qt::Window);
	QObject::connect(view.engine(), &QQmlEngine::quit, &app, &QGuiApplication::quit);
	view.show();

	Backend backend;

	QQmlEngine *engine = view.engine();
	engine->rootContext()->setContextProperty("Backend", &backend);

	return app.exec();
}
