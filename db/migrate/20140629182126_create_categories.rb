class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    for i in 1..10 do 
      Category.create!(:name => "Category #{i}")
    end
  end
end
