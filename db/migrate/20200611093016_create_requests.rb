class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :type_request
      t.datetime :time_late_to
      t.datetime :time_late_from
      t.datetime :time_back_early_to
      t.datetime :time_back_early_from
      t.datetime :time_add_to
      t.datetime :time_add_from
      t.datetime :time_out_to
      t.datetime :time_out_from
      t.text :reason
      t.integer :status , default: 0

      t.timestamps
    end
     add_reference :requests, :user, foreign_key: true

  end
end