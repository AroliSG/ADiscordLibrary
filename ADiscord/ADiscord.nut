dofile( "scripts/components/ADiscord/modules/parseJson.nut" );
dofile( "scripts/components/ADiscord/modules/ADLibrary.nut" );
dofile( "scripts/components/ADiscord/modules/addEventHandler.nut" );
    // events
dofile( "scripts/components/ADiscord/events/messages.nut");
dofile( "scripts/components/ADiscord/events/commons.nut");

class ADiscord {
    localSession            = null;
    session                 = null;

        // discord client resources
    channels                = null;
    guilds                  = null;
    user                    = null;
    roles                   = null;
    emojis                  = null;
    application             = null;
    slashCommands           = null;
    isReady                 = null;

        // commands prefix
    commandPrefix           = "!";

    function constructor () {
        this.user       = {
                // debug? when server reconnnect to the nodejs server we must provide this value otherwise will cause an error
            messageEmbed = null
        }
        localSession    = {};
    }

    function Init () {
        this.session = ::NewSocket( "onDDiscordUpdate" );
        this.session.Connect( "127.0.0.1", 4000);
        this.session.SetNewConnFunc( "onDDiscordUpdate" );

            // slash commands
        slashCommands = {
           // slash = commands,
         //   clientId = clientId
        };
    }

    function say (msg) {
        this.session.Send (msg + "-[ADiscord]-");
    }

    function Connect (token) {
        this.localSession.Token <- token;
    }
}

function onDDiscordUpdate (events = null) {
    if (!events) {
            // requirements to log-In bot
        local obj = {
            botToken        = ADiscord.localSession.Token,
            prefix          = ADiscord.commandPrefix,
            commandSlash    = ADiscord.slashCommands
        }

        ADiscord.say (toJSON (obj));
        return;
    }
    else {
            // events
        local data = split (events "*");
        local ADLibrary = ADLibrary.construct (data);
        addEventHandler.emit (data [0], ADLibrary);
    }
}

ADiscord <- ADiscord ();
    // provide a valid token otherwise the nodejs server will crash
ADiscord.Connect ("");
