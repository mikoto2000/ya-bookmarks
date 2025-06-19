class Oidc < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[issuer sub account_id id created_at updated_at]
  end
  belongs_to :account
end
