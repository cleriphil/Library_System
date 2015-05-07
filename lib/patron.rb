class Patron

attr_reader(:name, :id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes. fetch(:id).to_i()
  end
  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patron;")
    patrons = []
    returned_patrons.each() do |patron|
      @name = patron.fetch('name')
      @id = patron.fetch('id')
      patrons.push(Patron.new({:name => @name, :id => @id}))
    end
  patrons
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO patron (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.id().to_i().==(another_patron.id().to_i()))
  end
  define_singleton_method(:find) do |id|
    @id = id
    results = DB.exec("SELECT * FROM patron WHERE id = #{@id};")
    @name = results.first().fetch('name')
    Patron.new({:name => @name, :id => @id})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE patron SET name = '#{@name}' WHERE id = #{@id};")
  end
  define_method(:delete) do
    DB.exec("DELETE FROM patron WHERE id = #{self.id};")
  end

  define_method(:check_out) do |book|
    returned_copies = DB.exec("SELECT * FROM copies WHERE book_id = #{book.id()};")
    copy_ids = []
    returned_copies.each() do |copy|
      @copy_id =  copy.fetch('id')
      copy_ids.push(@copy_id)
    end
    copy_to_delete = copy_ids[-1]
    DB.exec("DELETE FROM copies WHERE id = #{copy_to_delete}")

    DB.exec("INSERT INTO check_out (patron_id, copy_id, book_id) VALUES (#{self.
    id()}, #{@copy_id}, #{book.id()});")
  end

  define_method(:history) do
    returned_check_outs = DB.exec("SELECT * FROM check_out WHERE patron_id = #{self.id()};")
    check_outs = []
    returned_check_outs.each() do |check_out|
      book_id = check_out.fetch('book_id')
      check_outs.push(Book.find_by_id(book_id))
    end
    check_outs
  end

end
