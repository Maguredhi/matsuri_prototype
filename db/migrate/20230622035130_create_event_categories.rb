class CreateEventCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :event_categories do |t|
      t.string :category

      t.timestamps
    end
  end
end
