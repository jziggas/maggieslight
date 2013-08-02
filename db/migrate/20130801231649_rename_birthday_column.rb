class RenameBirthdayColumn < ActiveRecord::Migration
  def change
    rename_column :care_receiver_profiles, :birthday, :birthdate
  end
end
