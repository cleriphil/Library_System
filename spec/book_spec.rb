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
end
