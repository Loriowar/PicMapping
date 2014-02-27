class CreatePicsTable < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      # max length on file name in unix 255 charecters
      t.string  :file_name,
                 limit: 255,
                 null: false
      # length of file path in unix is unlimited
      t.string  :file_path,
                 limit: 1000,
                 null: false
      t.boolean :is_processed, default: false

      t.timestamps
    end
  end
end
