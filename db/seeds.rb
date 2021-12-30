# Module Authors
puts 'Creating authors...'
first_authors = FactoryBot.create_list(:author, 2)
second_authors = FactoryBot.create_list(:author, 2)

# Module Books
puts 'Creating Books'

FactoryBot.create_list(:book, 3, published: true, authors: first_authors, quantity: 200)
FactoryBot.create_list(:book, 2, published: true, authors: second_authors, quantity: 100)
FactoryBot.create_list(:book, 2, published: false, authors: second_authors, quantity: 50)

# Module Users
puts 'Creating Users'
users = FactoryBot.create_list(:user, 5)
puts '  Blocked User'
FactoryBot.create(:user, email: 'blocked@gmail.com', password: '123456', blocked: true)

# Module Admin
puts 'Creating Admin'
FactoryBot.create(:admin, email: 'adm@bookstore.com', password: '123456')

# Module Orders
puts 'Creating Orders...'
first_item = FactoryBot.create(:item, quantity: 2, book: Book.first)
second_item = FactoryBot.create(:item, quantity: 3, book: Book.second)
FactoryBot.create(:order, items: [first_item], user: users.first)
FactoryBot.create(:order, items: [second_item], user: users.first)