class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.json :members, default: []
      t.json :dates_bucket_match, default: []
      t.timestamps
    end
  end
end
