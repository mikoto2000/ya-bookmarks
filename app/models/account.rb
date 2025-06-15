class Account < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[display_name id created_at updated_at]
  end
end
