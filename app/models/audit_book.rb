class AuditBook < ApplicationRecord
  belongs_to :admin
  belongs_to :book
end
