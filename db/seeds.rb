# Module Authors
puts 'Creating authors...'
first_authors = FactoryBot.create_list(:author, 2)
second_authors = FactoryBot.create_list(:author, 2)

# Module Books
puts 'Creating Books'

FactoryBot.create_list(:book, 3, published: true, authors: first_authors, quantity: 200)
FactoryBot.create_list(:book, 2, published: true, authors: second_authors, quantity: 100)
FactoryBot.create_list(:book, 2, published: false, authors: second_authors, quantity: 50)

# Module Orders
puts 'Creating Orders...'

first_item = FactoryBot.create(:item, quantity: 2, book: Book.first)
second_item = FactoryBot.create(:item, quantity: 3, book: Book.second)
FactoryBot.create(:order, items: [first_item])
FactoryBot.create(:order, items: [second_item])