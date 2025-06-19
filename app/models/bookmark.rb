class Bookmark < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[account_id page_id id created_at updated_at]
  end
  belongs_to :account
  belongs_to :page
end
