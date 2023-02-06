    // made it a table may be someday I need to add a new function or variable or may be na?
ADLibrary <- {
    function construct (data) {
        local parentArray = [{
            client  = ADiscord
        }];

            // message event
        if (data [0]=="message") {
            local message = fromJSON (data [1]);

                // reply message
            message.reply <- function (content) {
                local obj = {
                    channelEvent    = "reply",
                    messageId       = message.id,
                    channelId       = message.channelId,
                    content         = content
                }

                ADiscord.say (toJSON (obj));
            }
                // send message to channel
            message.channel.send <- function (content, channelId = message.channelId) {
                local obj = {
                    channelEvent    = "send",
                    channelId       = channelId,
                    content         = content
                }

                ADiscord.say (toJSON  (obj));
            }

            message.channel.messageEmbed <- function (data, channelId = message.channelId) {
                local obj = {
                    channelEvent    = "embed",
                    channelId       = channelId,
                    embeds          = data
                }
                if (!data.rawin ("Title") && !data.rawin ("Description")) throw "as discord requirements please provide atleast a title or a description";
                if (typeof data != "table") throw "data given is not a table";

                ADiscord.say (toJSON  (obj));
            }

            parentArray .push (message);
        }

        if (data [0]=="ready") {
            local client = fromJSON (data [1]);

                // assigning values to their corresponding
            ADiscord.user = client.user;
            ADiscord.application = client.application;
            ADiscord.guilds = client.guilds;
            ADiscord.channels = client.channels;
            ADiscord.emojis = client.emojis;
            ADiscord.roles = client.roles;

                // setActivity
            ADiscord.user.setActivity <- function (content) {
                local obj = { botEvent = "setActivity", content = content }
                ADiscord.say (toJSON  (obj));
            }

                // setAFK
            ADiscord.user.setAFK <- function (content) {
                local obj = { botEvent = "setAFK", content = content }
                ADiscord.say (toJSON  (obj));
            }

                // setAFK
            ADiscord.user.setStatus <- function (content) {
                local obj = { botEvent = "setStatus", content = content }
                ADiscord.say (toJSON  (obj));
            }

                // send mssage using client
            ADiscord.user.send <- function (content, channelId) {
                local obj = {
                    channelEvent    = "send",
                    channelId       = channelId,
                    content         = content
                }

                ADiscord.say (toJSON  (obj));
            }

                // send reply using client
            ADiscord.user.reply <- function (content, channelId, messageId) {
                local obj = {
                    channelEvent    = "reply",
                    channelId       = channelId,
                    messageId       = messageId
                    content         = content
                }

                ADiscord.say (toJSON  (obj));
            }
        }
            // pushing error message to be shown
        if (data [0]=="error") {
            parentArray .push (data [1]);
        }

            // send embeds using client
        ADiscord.user.messageEmbed <- function (data, channelId) {
            local obj = {
                channelEvent    = "embed",
                channelId       = channelId,
                embeds          = data
            }
            if (!data.rawin ("Title") && !data.rawin ("Description")) throw "as discord requirements please provide atleast a title or a description";
            if (typeof data != "table") throw "data given is not a table";

            ADiscord.say (toJSON  (obj));
        }
        return parentArray;
    }
}