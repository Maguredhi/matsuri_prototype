class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.string :status, default: 'draft'
      t.string :venue
      t.string :location
      t.datetime :released_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
