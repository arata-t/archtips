class CreateTips < ActiveRecord::Migration[6.0]
  def change
    create_table :tips do |t|
      t.string      :title,       null: false
      t.integer     :category_id, null: false
      t.text        :description, null: false
      t.timestamps
    end
  end
end
