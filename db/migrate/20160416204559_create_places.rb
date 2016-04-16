class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :city
      t.string :state
      t.string :country
      t.string :keywords
      t.string :region
      t.string :wiki
      t.string :language
      t.string :image

      t.timestamps null: false
    end
  end
end
