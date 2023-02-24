#include <QGuiApplication>
#include <QQmlApplicationEngine>
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
	view.show();

	return app.exec();
}
