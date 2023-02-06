### ADiscord 
A Vice City Multiplayer Server Side Library for integrating Discordjs 
 
 ### Requirements
1. Lastest stable version of [nodejs](nodejs.org)
2. VC MP [Json](https://forum.vc-mp.org/?topic=1479.msg10253#msg10253) module by Crys 
 
 ### Installation and Guide
 ## ADiscord Nodejs/Server
 1. npm install using a [cmd/shell] in the root directory
 2. run ADiscord with
   > node ADiscord

## ADiscord Squirrel
1. place ADiscord Folder inside Script
2. dofile the files
3. init ADiscord at Server ScriptLoad

```
   dofile( "scripts/ADiscord/ADiscord.nut" );
   ADiscord.Init ()
```

## Important to read
1. When using ADiscord.user.send or ADiscord.user.messageEmbed outside of a ADiscord event you must be sure ADiscord is running
2. So, you must provide ADiscord.ready, to make sure is safety to use any function, if not provided can cause a crash intentionally
```
onPlayerJoin (player) {
      // secure to use
   if (ADiscord.ready) ADiscord.user.send ("testing", channelId);
      // can cause crashes
   ADiscord.user.send ("testing", channelId);
}
```

### Another thing to mention, is when using vcmp global variables inside an ADiscord Event, 'Important'
1. not in all cases, but I encounter few problems when calling vcmp variables.
2. I suggest using :: on every variable used inside, Ex.
```
   addEventHandler.on ("message", function (message) {
      ::Message ("good :D");
      Message ("this can cause trouble");
         // always use :: to make sure the good working of ur server, only when calling vcmp properties/variables
      ::GetPlayers ();
   });
```



## Usage
Remember you can print all client members

1. ADiscord.user
2. ADiscord.application
3. ADiscord.guilds
4. ADiscord.channels
5. ADiscord.emojis
6. ADiscord.roles

once ADiscord is ready you can print all members one by one
> print (toJSON (ADiscord.user));

also when using the message listener or command listener you can just do
> print (toJSON (message));

if that wasn't enought refer to the [Wiki](https://github.com/AroliSG/ADiscordLibrary/wiki)
