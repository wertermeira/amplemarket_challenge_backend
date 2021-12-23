class CreateTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :templates, id: :uuid do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
