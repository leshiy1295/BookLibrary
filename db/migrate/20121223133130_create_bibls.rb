class CreateBibls < ActiveRecord::Migration
  def change
    create_table :bibls do |t|
      t.string :source
      t.text :title
      t.string :author
      t.string :subject
      t.string :publisher
      t.string :format
      t.string :language
	  
      t.timestamps
    end
  end
end
