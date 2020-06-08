class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :plan_daily
      t.text :actual_work
      t.text :next_plan
      t.text :issue
      t.datetime :time_submit

      t.timestamps
    end
    #add_index :reports, [:user_id, :created_at]
  end
end
