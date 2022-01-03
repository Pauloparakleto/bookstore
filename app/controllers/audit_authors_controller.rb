class AuditAuthorsController < ApplicationController
  # TODO, Name presenter as 'first name last name'
  
  before_action :authenticate_admin!
  
  def index
    # TODO, presenter to index when field is empty 'no changes'
    @audit_authors = AuditAuthor.all
  end
end
