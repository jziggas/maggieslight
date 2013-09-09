class CreatePageFeedbacksTable < ActiveRecord::Migration
  def change
    create_table :page_feedbacks do |t|
      t.string :feedback
      t.string :controller
      t.string :action
      t.integer :user_id
    end
  end
end
