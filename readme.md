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

### Important to read
When using ADiscord.user.send or ADiscord.user.messageEmbed outside of a ADiscord event you must be sure ADiscord is running
```
onPlayerJoin (player) {
   1. So, you must provide ADiscord.ready, to make sure is safety to use any function, if not provided can cause a crash intentionally
   2. this is secure to use
   if (ADiscord.ready) ADiscord.user.send ("testing", channelId);

   1. Ex of bad use
   2. this can cause a crash, make sure to use it properly
   ADiscord.user.send ("testing", channelId);
}
```

```
   dofile( "scripts/ADiscord/ADiscord.nut" );
   ADiscord.Init ()
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
