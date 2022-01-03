# Module Authors
puts 'Creating authors...'
first_authors = FactoryBot.create_list(:author, 2)
second_authors = FactoryBot.create_list(:author, 4)

# Module Books
puts 'Creating Books'

FactoryBot.create_list(:book, 10, published: true, authors: first_authors, quantity: 200)
FactoryBot.create_list(:book, 2, published: true, authors: second_authors, quantity: 100)
FactoryBot.create_list(:book, 2, published: false, authors: second_authors, quantity: 50)

# Module Users
puts 'Creating Users'
users = FactoryBot.create_list(:user, 5)
puts '  Blocked User'
User.find_by_email('blocked@gmail.com').destroy
FactoryBot.create(:user, email: 'blocked@gmail.com', password: '123456', blocked: true)

# Module Admin
puts 'Creating Admin'
Admin.find_by_email('adm@bookstore.com').destroy
admin = FactoryBot.create(:admin, email: 'adm@bookstore.com', password: '123456')

# Module Orders
puts 'Creating Orders...'
first_item = FactoryBot.create(:item, quantity: 2, book: Book.first)
second_item = FactoryBot.create(:item, quantity: 3, book: Book.second)
FactoryBot.create(:order, items: [first_item], user: users.first)
FactoryBot.create(:order, items: [second_item], user: users.first)

# Module Audit Books
puts 'Creating Audit Books'
FactoryBot.create_list(:audit_book, 6, admin: admin, book: Book.first)

# Module Audit Books
puts 'Creating Audit Authors'
FactoryBot.create_list(:audit_author, 6, admin: admin, author: Author.first)