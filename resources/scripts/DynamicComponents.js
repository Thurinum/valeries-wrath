function spawn(path, ancestor, properties) {
    let component = Qt.createComponent("qrc:/resources/qml/" + path + ".qml")

    if (component.status === Component.Ready)
        create(component, ancestor, properties);
    else if (component.status === Component.Error)
        console.log("Failed to load component: " + component.errorString())

    component.statusChanged.connect(() => {
                                        console.log("bruh")
                              create(component, ancestor, properties)
                          })
}

function create(component, ancestor, properties) {
    if (component.status === Component.Ready) {
        let object = component.createObject(ancestor, properties);

        if (object === null) {
            console.log("Failed to load component.");
        }
    } else if (component.status === Component.Error) {
        console.log("Failed to create component:", component.errorString());
    }
}
