class Book

  attr_reader(:author, :title, :id)

  define_method(:initialize) do |attributes|
    @author = attributes.fetch(:author)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end
  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM book;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      author = book.fetch("author")
      id = book.fetch("id")
      books.push(Book.new({:title => title, :author => author, :id => id}))
    end
    books
  end
    define_method(:save) do
      result = DB.exec("INSERT INTO book (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end
    define_method(:==) do |another_book|
      self.title().==(another_book.title()).&(self.id().to_i().==(another_book.id().to_i())).&(self.author().==(another_book.author()))
    end


end
