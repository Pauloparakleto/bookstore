class AuditsController < ApplicationController
  def index
    # TODO, presenter to index when field is empty 'no changes'
    @audit_books = AuditBook.all
  end
end
