# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


john = User.create(name: 'John')
jack = User.create(name: 'Jack')

jack_john_chat = Chat.create(chat_type: 'direct')
ChatUser.create(chat: jack_john_chat, user: john)
ChatUser.create(chat: jack_john_chat, user: jack)

message1 = Message.create \
  chat: jack_john_chat,
  sender_user: john,
  content: 'Hello, this is John'

message2 = Message.create \
  chat: jack_john_chat,
  sender_user: jack,
  content: 'Hello, John. My name is Jack'

track1 = MessageTrack.create \
   chat: jack_john_chat,
   message: message1,
   recipient_user: jack,
   sent_at: DateTime.now,
   delivered_at: DateTime.now,
   read_at: DateTime.now

track2 = MessageTrack.create \
   chat: jack_john_chat,
   message: message2,
   recipient_user: john,
   sent_at: DateTime.now