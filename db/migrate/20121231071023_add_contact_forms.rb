class AddContactForms < ActiveRecord::Migration
  def up
    create_table :spree_contact_topics do |t|
      t.string :name
      t.string :emails
      t.timestamps
    end
    create_table :spree_messages do |t|
      t.belongs_to :topic
      t.string :name,  :null => false
      t.string :email,    :null => false
      t.string :order_number
      t.text   :message,  :null => false
      t.timestamps
    end
  end

  def down
    drop_table :spree_contact_topics
    drop_table :spree_messages
  end
end
