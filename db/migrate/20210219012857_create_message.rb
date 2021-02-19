class CreateMessage < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.references :sender_id, foreign_key:{to_table: :users}
      t.references :receiver_id, foreign_key:{to_table: :users}

      t.timestamps
    end
  end
end
