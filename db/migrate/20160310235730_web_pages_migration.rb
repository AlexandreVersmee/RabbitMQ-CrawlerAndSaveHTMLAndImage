class WebPagesMigration < ActiveRecord::Migration
  def change
    create_table :web_pages do |t|
      t.text :html
    end
  end
end
