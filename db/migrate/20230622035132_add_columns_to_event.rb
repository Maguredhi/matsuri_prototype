class AddColumnsToEvent < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :event_category, foreign_key: true
    add_reference :events, :event_datetime, foreign_key: true
  end
end
