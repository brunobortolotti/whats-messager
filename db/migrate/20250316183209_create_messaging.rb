class CreateMessaging < ActiveRecord::Migration[7.0]
  def change
    create_table :threads, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :label
      t.string :thread_type
      t.timestamps
    end

    create_table :messages, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :thread_id, null: false
      t.uuid :sender_user_id, null: false
      t.text :content, null: false
      t.timestamps
    end

    create_table :thread_users, id: false do |t|
      t.uuid :thread_id, null: false
      t.uuid :user_id, null: false
      t.integer :unread_count, null: false, default: 0
    end

    create_table :thread_user_messages, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :thread_id, null: false
      t.uuid :message_id, null: false
      t.uuid :recipient_user_id, null: false
      t.datetime :sent_at
      t.datetime :delivered_at
      t.datetime :read_at
    end

    add_foreign_key :messages, :threads, column: :thread_id, primary_key: :id
    add_foreign_key :messages, :users, column: :sender_user_id, primary_key: :id
    add_foreign_key :thread_users, :threads, column: :thread_id, primary_key: :id
    add_foreign_key :thread_users, :users, column: :user_id, primary_key: :id
    add_foreign_key :thread_user_messages, :threads, column: :thread_id, primary_key: :id
    add_foreign_key :thread_user_messages, :messages, column: :message_id, primary_key: :id
    add_foreign_key :thread_user_messages, :users, column: :recipient_user_id, primary_key: :id
  end
end
