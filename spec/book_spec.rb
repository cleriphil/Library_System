require('rspec')
require('book')
require('pry')

describe(Book) do
  describe('#title') do
    it('returns the title of the book')do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil})
      expect(test_book.title()).to(eq("Welcome to the neighborhood"))
    end
  end
  describe('#author') do
    it('returns the author of the book')do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => nil})
      expect(test_book.author()).to(eq("Mr. Rogers"))
    end
  end
  describe('#id') do
    it('returns the id of the book')do
      test_book = Book.new({:title => "Welcome to the neighborhood", :author => "Mr. Rogers", :id => 1})
      expect(test_book.id()).to(eq(1))
    end
  end
end
