class AddSlugToPost < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :slug
    end
  end
end
