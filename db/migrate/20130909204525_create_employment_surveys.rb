class CreateEmploymentSurveys < ActiveRecord::Migration
  def change
    create_table :employment_surveys do |t|
      t.integer :user_id
      t.string :kind_of_ad
      t.string :contact
      t.string :employment
      t.timestamps
    end
  end
end
