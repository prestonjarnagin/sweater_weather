class CreateUserCities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_cities do |t|
      t.references :user, foreign_key: true
      t.references :city, foreign_key: true
    end
  end
end
