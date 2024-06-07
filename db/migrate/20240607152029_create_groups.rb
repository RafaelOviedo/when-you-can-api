class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.json :members, default: []
      t.date :start_date_bucket_match
      t.date :end_date_bucket_match
      t.timestamps
    end
  end
end
