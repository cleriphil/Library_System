require('spec_helper')

describe(Book) do
  describe('#title') do
    it('returns the title of the book')do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => nil})
      expect(test_book.title()).to(eq("Welcome to the neighborhood"))
    end
  end
  describe('#author') do
    it('returns the author of the book')do
    test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => nil})
      expect(test_book.author()).to(eq("Mr. Rogers"))
    end
  end
  describe('#id') do
    it('returns the id of the book')do
    test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => nil})
      expect(test_book.id()).to(eq(1))
    end
  end
  describe('.all') do
    it('returns all the books') do
    expect(Book.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('saves the book to database') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => nil})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end
  describe('.find_by_id') do
    it('finds the book by its id') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => nil})
      test_book.save()
      expect(Book.find_by_id(test_book.id())).to(eq(test_book))
    end
  end
  describe('.find_by_title') do
    it('finds the book by its title') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => nil})
      test_book.save()
      expect(Book.find_by_title(test_book.title())).to(eq(test_book))
    end
  end
  describe('.find_by_author') do
    it('finds the book by its author') do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil, :copy_id => nil})
      test_book.save()
      expect(Book.find_by_author(test_book.author())).to(eq(test_book))
    end
  end
  describe('#update') do
    it('lets you update books in the database') do
      test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => nil, :copy_id => nil})
      test_book.save()
      test_book.update({:title => "The giving tree"})
      expect(test_book.title()).to(eq("The giving tree"))
      test_book.update({:author => "Dr. Suess"})
      expect(test_book.author()).to(eq("Dr. Suess"))
    end
  end
  describe('#delete') do
    it('lets you delete a book from the database') do
      test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => nil, :copy_id => nil})
      test_book.save()
      test_book.delete()
      expect(Book.all()).to(eq([]))
    end
  end
  # describe('#make_copy') do
  #   it('lets you make a copy of a book') do
  #     test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => 5})
  #
  #     test_book.save()
  #     test_book.make_copy()
  #     test_copies = test_book.copies()
  #     expect(test_copies[0].to(eq())
  #     # expect(test_book.copies().length()).to(eq(1))
  #   end
  # end
  # describe('#copies') do
  #   it('lets you see the copies of a book') do
  #     test_book = Book.new({:title => "Where the sidewalk ends", :author => "Shel Silverstine", :id => 5})
  #     test_book.save()
  #     # DB.exec("INSERT INTO book (title, author, id) VALUES ('Where the sidewalk ends', 'Shel Silverstine', 5);")
  #     # DB.exec("INSERT INTO copies (id, book_id) VALUES (2, 5);")
  #     copied_things = DB.exec(SELECT * FROM copies)
  #     expect(test_book.copies()[0].id()).to(eq(1))
  #   end
  # end
end
