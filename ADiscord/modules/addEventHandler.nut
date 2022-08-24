class addEventHandler {
    events = null;
    constructor () {
        this.events = {};
    }

    on = function (eventName, callback) {
        this.events.rawset (eventName, callback);
    }

    remove = function (name) {
        if (!this.events.rawin(name)) throw "cant remove event named "+name+" cuz it  doesn't exist.";
        this.events.rawdelete(name);
    }

    emit = function (name, data) {
        if (this.events.rawin(name)) {
           local eventFunc = this.events.rawget (name);
           eventFunc.acall (data);
        }
    }
}

addEventHandler <- addEventHandler ();
