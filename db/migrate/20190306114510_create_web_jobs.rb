class CreateWebJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :web_jobs do |t|
      t.text :url
      t.string :req_user_name
      t.string :result_path

      t.timestamps
    end
  end
end
