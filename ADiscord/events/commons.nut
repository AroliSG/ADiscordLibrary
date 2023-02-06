addEventHandler.on ("ready", function () {
    print("Discord bot connection established successfully.");
    client.user.setActivity ("RP BOT MADE BY kk");
    // client.user.setStatus ("Testing status");
    // client.user.setAFK (true);
    print (toJSON (client.user))
        // client is ready
    client.ready = true;
});

addEventHandler.on ("error", function (error) {
    print (error)
});

addEventHandler.on ("disconnect", function () {

});


addEventHandler.on ("quit", function () {
});