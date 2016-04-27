class ImagesMigration < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.binary :content
    end
  end
end
