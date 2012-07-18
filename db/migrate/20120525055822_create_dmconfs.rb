class CreateDmconfs < ActiveRecord::Migration
  def change
    create_table :dmconfs do |t|
      t.string :path
      t.string :content

      t.timestamps
    end
  end
end
