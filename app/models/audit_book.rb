class AuditBook < ApplicationRecord
  belongs_to :admin
  belongs_to :book

  enum published: { published: true, unpublished: false }
end
