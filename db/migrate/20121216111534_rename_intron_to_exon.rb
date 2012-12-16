class RenameIntronToExon < ActiveRecord::Migration
  def change
    rename_table :introns, :exons
    rename_column :variations, :intron_id, :exon_id
  end
end
