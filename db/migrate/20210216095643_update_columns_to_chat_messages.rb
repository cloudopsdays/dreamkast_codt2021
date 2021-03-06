class UpdateColumnsToChatMessages < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :chat_messages, :talks
    remove_index :chat_messages, :talk_id
    remove_reference :chat_messages, :talk, index: true

    remove_foreign_key :chat_messages, :booths
    remove_index :chat_messages, :booth_id
    remove_reference :chat_messages, :booth, index: true

    add_column :chat_messages, :room_type, :string
    add_column :chat_messages, :room_id, :bigint
  end
end
