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

  define_singleton_method(:find_by_id) do |id|
    @id = id
    result = DB.exec("SELECT * FROM book WHERE id = #{@id}")
    @title = result.first().fetch("title")
    @author = result.first().fetch("author")
    Book.new({:title => @title, :author => @author, :id => @id})
  end

  define_singleton_method(:find_by_title) do |title|
    @title = title
    result = DB.exec("SELECT * FROM book WHERE title = '#{@title}'")
    @id = result.first().fetch("id")
    @author = result.first().fetch("author")
    Book.new({:title => @title, :author => @author, :id => @id})
  end

  define_singleton_method(:find_by_author) do |author|
    @author = author
    result = DB.exec("SELECT * FROM book WHERE author = '#{@author}'")
    @id = result.first().fetch("id")
    @title = result.first().fetch("title")
    Book.new({:title => @title, :author => @author, :id => @id})
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @author = attributes.fetch(:author, @author)
    @id = self.id
    if @title.!=(self.title())
      DB.exec("UPDATE book SET title = '#{@title}' WHERE id = #{@id};")
    end
    if @author.!=(self.author())
      DB.exec("UPDATE book SET author = '#{@author}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM book WHERE id = #{self.id()};")
  end

  define_method(:make_copy) do
    result = DB.exec("INSERT INTO copies (book_id) VALUES ('#{self.id()}')")
  end

  define_method(:copies) do
    returned_copies = DB.exec("SELECT * FROM copies WHERE book_id = '#{self.id()}'")
    index = 0
    returned_copies.each() do |copy|
      index = index + 1
    end
    index
  end
end
