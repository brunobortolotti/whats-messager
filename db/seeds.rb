# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


john = User.create(name: 'John')
jack = User.create(name: 'Jack')
josh = User.create(name: 'Josh')


chat1 = Chat.create(chat_type: 'direct')
[john, jack].each { |user| ChatUser.create(chat: chat1, user:) }

message1 = Message.create \
  chat: chat1,
  sender_user: john,
  content: 'Hello, this is John'

chat1.users.where.not(id: john.id).each do |user|
  MessageTrack.create \
    chat: chat1,
    message: message1,
    recipient_user: user,
    sent_at: DateTime.now,
    delivered_at: DateTime.now,
    read_at: DateTime.now
end

message2 = Message.create \
  chat: chat1,
  sender_user: jack,
  content: 'Hello, John. My name is Jack'

chat1.users.where.not(id: jack.id).each do |user|
  MessageTrack.create \
    chat: chat1,
    message: message2,
    recipient_user: user,
    sent_at: DateTime.now,
    delivered_at: DateTime.now,
    read_at: DateTime.now
end

chat2 = Chat.create(chat_type: 'group')
[john, jack, josh].each { |user| ChatUser.create(chat: chat2, user:) }

message3 = Message.create \
  chat: chat2,
  sender_user: jack,
  content: 'Hey guys. I\'m Jack'

message4 = Message.create \
  chat: chat2,
  sender_user: josh,
  content: 'Hey guys. I\'m Josh'

message5 = Message.create \
  chat: chat2,
  sender_user: john,
  content: 'Hey guys. I\'m John'

[message3, message4, message5].each do |message|
  chat2.users.where.not(id: message.sender_user.id).each do |user|
    MessageTrack.create \
      chat: chat2,
      message: message,
      recipient_user: user,
      sent_at: DateTime.now,
      delivered_at: DateTime.now,
      read_at: DateTime.now
  end
end
