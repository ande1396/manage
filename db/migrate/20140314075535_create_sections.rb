class CreateSections < ActiveRecord::Migration


	# 'change' runs the commands as given wehn migrating "up"
	#only runs the reverse of the commands when migrating "down"
	#ONly works if all commands are reversible.
	#for ex;
	#  add_column can be reversed as remove_column
	#   it has all of the info remove_column needs
	# remove_column can't be reversed as add_column
	## it doesn't have the comumn definition add-column needs 
	
  def change
    create_table :sections do |t|

    	#the change method is the simplified version
      t.integer "page_id"
      ### same as: t.references :page
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "content_type"
      t.text "content"

      t.timestamps
    end
    add_index("sections", "page_id")
  end
end
