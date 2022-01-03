class AuditsController < ApplicationController
  before_action :authenticate_admin!
  def index
    # TODO, presenter to index when field is empty 'no changes'
    @audit_books = AuditBook.all
  end
end
