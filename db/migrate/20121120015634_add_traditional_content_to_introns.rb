class AddTraditionalContentToIntrons < ActiveRecord::Migration
  def change
    add_column :introns, :traditional_content, :string
  end
end
