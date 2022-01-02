class AuditAuthor < ApplicationRecord
  belongs_to :admin
  belongs_to :author
end
