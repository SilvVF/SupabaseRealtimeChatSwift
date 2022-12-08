# SupabaseRealtimeChatSwift

Swift version of the supabase realtime chat sample android version found here https://github.com/SilvVF/SupabaseRealtimeChatSample .
Uses the realtime feature to create a chat app from observing changes to a postgres DB in realtime.
The package for the supabase swift client can be found here https://github.com/supabase-community/supabase-swift .

image
Supabase Postgres table
The Postgres database contains one table which is the messages table. All chat messages in the app are going to be broadcast to an all chat of users that observe the changes to this table.

Each row in the table represents a single message sent by a user the Model Message will be used in the app as a Swift Struct. The Postgres table messages in the image represents what the table looks like in supabse table editor. Supabase has default implementations for assigning default values on inserts. In this project the timestamp and UUID genereate default ones are used.

## Install the supabase swift package

First you will need to install the supabase package in order to use the supbase client.
guides to do this can be found here https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app

https://github.com/supabase/supabase-swift.git

Now all you need to do is add the necessary import to start using the supabase package.
In this app two will be used: 
import Supabase
import Realtime

## data package

The data service conatins one file the ChatService.swift .
This constructor of the ChatService creates the supabase client since this will only be used a single time within the app.

The ChatService is responsible for connecting to the realtime client and providing a method to subscribe to updates and also to insert data into the table. Inside this file the api key and url is obtained through the keys.plist file. This contains the api keys so they will not be visible on github. These can be found on supabase throught the project settings and can be used directly. When using the supabase package the realtime url will be automatically generated for you and you can connect to the realtime feature by simply using the SupabaseClient.realtime
first connect to the realtime client by calling - client.realtime.connect()
create a channel with the changes you would like to listen for - let channel = client.realtime.channl( .table("table_name", schema: "public))

you can create different filters for the channel in this case we will subscribe to updates from the messages table. If you are just creating a project then the schema will likely be "public" this can be found in your supabse project settings.
you can also filter by differnent postgres actions such as inserts.
to do this call channel.on(.insert, callback: yourFunction)
this will call your function passed to callback only on inserts





To subscribe to updates 
