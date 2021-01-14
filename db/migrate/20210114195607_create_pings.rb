class CreatePings < ActiveRecord::Migration[6.1]
  def change
    create_table :pings do |t|
      t.string :name
      t.timestamps
    end
  end
end
