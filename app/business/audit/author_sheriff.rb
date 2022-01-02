module Audit
  class AuthorSheriff
    attr_reader :admin, :author
    attr_accessor :first_name, :last_name

    def initialize(attributes, models)
      @attributes = attributes
      @admin = models.fetch(:admin)
      @author = models.fetch(:author)
      set_attributes_differences
    end

    def author_attributes_to_compare
      author.attributes.slice('first_name', 'last_name').symbolize_keys
    end

    def set_attributes_differences
      set_first_name_difference
      set_last_name_difference
    end

    def create
      return unless there_is_changes

      set_attributes_differences
      AuditAuthor.create(admin_id: admin.id, author_id: author.id, first_name: first_name, last_name: last_name)
    end

    def there_is_changes
      [first_name, last_name].any?
    end

    private

    def set_first_name_difference
      @first_name = @attributes.fetch(:first_name) unless author_attributes_to_compare.fetch(:first_name)
        .eql?(@attributes.fetch(:first_name))
    end

    def set_last_name_difference
      @last_name = @attributes.fetch(:last_name) unless author_attributes_to_compare.fetch(:last_name)
        .eql?(@attributes.fetch(:last_name))
    end
  end
end
