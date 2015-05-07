class Book

  attr_reader(:author, :title, :id, :copy_id)

  define_method(:initialize) do |attributes|
    @author = attributes.fetch(:author)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
    @copy_id = attributes.fetch(:copy_id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM book;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      author = book.fetch("author")
      id = book.fetch("id")
      copy_id = book.fetch('copy_id')
      books.push(Book.new({:title => title, :author => author, :id => id, :copy_id => copy_id}))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO book (title, author, copy_id) VALUES ('#{@title}', '#{@author}', #{@copy_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.id().to_i().==(another_book.id().to_i())).&(self.author().==(another_book.author()))
  end

  define_singleton_method(:find_by_id) do |id|
    @id = id
    result = DB.exec("SELECT * FROM book WHERE id = #{@id};")
    @title = result.first().fetch("title")
    @author = result.first().fetch("author")
    @copy_id =  result.first().fetch("copy_id")
    Book.new({:title => @title, :author => @author, :id => @id, :copy_id => @copy_id})
  end

  define_singleton_method(:find_by_title) do |title|
    @title = title
    result = DB.exec("SELECT * FROM book WHERE title = '#{@title}';")
    @id = result.first().fetch("id")
    @author = result.first().fetch("author")
    @copy_id =  result.first().fetch("copy_id")
    Book.new({:title => @title, :author => @author, :id => @id, :copy_id => @copy_id})
  end

  define_singleton_method(:find_by_author) do |author|
    @author = author
    result = DB.exec("SELECT * FROM book WHERE author = '#{@author}';")
    @id = result.first().fetch("id")
    @title = result.first().fetch("title")
    @copy_id =  result.first().fetch("copy_id")
    Book.new({:title => @title, :author => @author, :id => @id, :copy_id => @copy_id})
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @author = attributes.fetch(:author, @author)
    @copy_id = attributes.fetch(:copy_id, @copy_id)
    @id = self.id
    if @title.!=(self.title())
      DB.exec("UPDATE book SET title = '#{@title}' WHERE id = #{@id};")
    end
    if @author.!=(self.author())
      DB.exec("UPDATE book SET author = '#{@author}' WHERE id = #{@id};")
    end
    if @copy_id.!=(self.copy_id())
      DB.exec("UPDATE book SET copy_id = '#{@copy_id}' WHERE id = #{@id};")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM book WHERE id = #{self.id()};")
  end

  define_method(:all_copies) do
    returned_copies = DB.exec("SELECT * FROM copies WHERE book_id = '#{self.id()}';")
    copies = []
    returned_copies.each() do |copy|
      copy_id = copy.fetch("id")
      copies.push(Book.new({:title => self.title(), :author => self.author(), :id => self.id(), :copy_id => copy_id}))
    end
    copies
  end

  define_method(:make_copy) do
    DB.exec("INSERT INTO copies (book_id) VALUES (#{self.id()});")
  end

  define_singleton_method(:overdue) do
    returned_checkouts = DB.exec("SELECT * FROM check_out;")
    today = Time.new()
    tday = today.day()
    tmonth = today.month()
    tyear = today.year()
    due_array = []
    due_final = []
    returned_checkouts.each() do |check_out|

      @book_id = check_out.fetch('book_id')
      @book_id = @book_id.to_i()
binding.pry
      @new_book = Book.find_by_id(@book_id)
      due = check_out.fetch('due')

      due_array.push(due)
      due_array.each() do |date|

        test_date = date.split()
        test_date = test_date[0].split('-')

        if tyear.>((test_date[0]).to_i())
          due_final.push(@new_book)
        elsif tmonth.>((test_date[1]).to_i())
          due_final.push(@new_book)
        else tday.>((test_date[2]).to_i())
          due_final.push(@new_book)
        end
      end
    end
    due_final
  end
end
