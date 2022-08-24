dofile( "scripts/ADiscord/events/commands.nut");

addEventHandler.on ("message", function (message) {
        // will reply back
    message.reply ("urbany es pro");

        // will send a message
        // can be used with a second parameter as channel id - .send (content, channelId)
    message.channel.send ("Hi!");

        // will send an embed message to the channel, also can send the message where you want add channelId to the table and add the channel id
    message.channel.messageEmbed ({
            // can also accept hex colors
        Color       = (0x0099FF)

        // just message
        Title       = "Sample Embed"
        Description = "sample embed with ADiscord"

            // field name is necessary the rest are not
        Author      = {
            name    = message.author.username,
            iconURL = message.author.displayAvatarURL,
            url     = message.author.displayAvatarURL
        }
            // just an image url
        Thumbnail   = message.author.displayAvatarURL
        Image       = message.author.displayAvatarURL

            // just an url
        URL         = message.author.displayAvatarURL

            // add as many fields as you want
            // inline is not a necessary field as field requirements
        Fields      = [
            { name = "Regular field title", value = "Some value here" },
            { name = "\u200B", value = "\u200B" },
            { name = "Inline field title", value = "Some value here", inline = true },
            { name = "Inline field title", value = "Some value here", inline = true },
        ]

            // footer
            // icon url is not a necessary field
        Footer      = {
            text = "Some footer text here",
            iconURL = "https://i.imgur.com/AfFp7pu.png"
        }
    });

        // will output a json string
    print (toJSON (message.members));

        // commands
    if (message. rawin ("command")) {
        addEventHandler.emit ("command", [
            parseJson,
            message.command,
            message.prefix,
            message
        ]);
    }
});
