# SupabaseRealtimeChatSwift

Swift version of the supabase realtime chat sample android version found here https://github.com/SilvVF/SupabaseRealtimeChatSample .
Uses the realtime feature to create a chat app from observing changes to a postgres DB in realtime.
The package for the supabase swift client can be found here https://github.com/supabase-community/supabase-swift .

image
Supabase Postgres table
The Postgres database contains one table which is the messages table. All chat messages in the app are going to be broadcast to an all chat of users that observe the changes to this table.

Each row in the table represents a single message sent by a user the Model Message will be used in the app as a Swift Struct. The Postgres table messages in the image represents what the table looks like in supabse table editor. Supabase has default implementations for assigning default values on inserts. In this project the timestamp and UUID genereate default ones are used.
