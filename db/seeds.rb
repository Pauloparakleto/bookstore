first_authors = FactoryBot.create_list(:author, 2)
second_authors = FactoryBot.create_list(:author, 2)
FactoryBot.create_list(:book, 3, published: true, authors: first_authors)
FactoryBot.create_list(:book, 2, published: true, authors: second_authors)
