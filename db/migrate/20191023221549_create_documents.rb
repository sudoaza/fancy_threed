class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.datetime :publish_date

      t.string :url
      t.string :source
      t.string :title
      t.string :keywords
      t.string :doctype

      t.text :summary
      t.text :body

      t.timestamps
    end
  end
end
