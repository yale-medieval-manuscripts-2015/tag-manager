class DeviseCreateUsers < ActiveRecord::Migration
  def change
    drop_table (:users)
  end
