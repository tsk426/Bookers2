class AddNameAndIntroductionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :image, :string
    add_column :users, :introduction, :text
  end
end
