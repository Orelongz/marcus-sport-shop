class CreateUrlMediaFiles < ActiveRecord::Migration[7.2]
  def change
    create_table :url_media_files do |t|
      t.string :url

      t.belongs_to :url_media_able, polymorphic: true

      t.timestamps
    end
  end
end
