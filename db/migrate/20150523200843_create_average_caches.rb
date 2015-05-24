class CreateAverageCaches < ActiveRecord::Migration
  def change
    create_table :average_caches do |t|
      t.belongs_to :rater
      t.belongs_to :rateable, polymorphic: true
      t.float :avg, null: false
      t.timestamps
    end
  end
end

