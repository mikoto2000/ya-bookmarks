class Page < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[url id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["accounts"]
  end
end
