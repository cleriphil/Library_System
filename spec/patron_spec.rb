require('spec_helper')

describe(Patron) do
  describe('#name') do
    it('returns the name of the patron') do
      test_patron = Patron.new({:name => "Johnny", :id => 1})
      expect(test_patron.name()).to(eq("Johnny"))
    end
  end

  describe('#id') do
    it('returns the id of the patron') do
      test_patron = Patron.new({:name => "Johnny", :id => 1})
      expect(test_patron.id()).to(eq(1))
    end
  end
  describe('.all') do
    it('returns all the patrons') do
    expect(Patron.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('saves the patron to the database') do
    test_patron = Patron.new({:name => "Johnny", :id => nil})
    test_patron.save()
    expect(Patron.all()).to(eq([test_patron]))
    end
  end
  describe('.find') do
    it('returns the patron by his/her id') do
    test_patron = Patron.new({:name => "Johnny", :id => nil})
    test_patron.save()
    expect(Patron.find(test_patron.id())).to(eq(test_patron))
    end
  end
  describe('#update') do
    it('updates the database with new information') do
      test_patron = Patron.new({:name => "Samnson", :id => nil})
      test_patron.save()
      test_patron.update({:name => "Sandra"})
      expect(test_patron.name()).to(eq("Sandra"))
    end
  end

  describe('#delete') do
    it('deletes a patron from the database') do
      test_patron = Patron.new({:name => "Samnson", :id => nil})
      test_patron.save()
      test_patron.delete()
      expect(Patron.all()).to(eq([]))
    end
  end
  describe('#check_out') do
    it('allows a patron to check out a book') do
      test_patron = Patron.new({:name => "Samnson", :id => nil})
      test_patron.save()
      test_book = Book.new({:title => "Birds", :author => "Joe", :id => nil, :copy_id => 0})
      test_book.save()
      test_book.make_copy()
      test_patron.check_out(test_book)
      expect(test_book.all_copies()).to(eq([]))
    end
  end
    describe('#history') do
      it('allows a patron to view their check out history') do
        test_patron = Patron.new({:name => "Samnson", :id => nil})
        test_patron.save()
        test_book = Book.new({:title => "Birds", :author => "Joe", :id => nil, :copy_id => 0})
        test_book.save()
        test_book_2 = Book.new({:title => "Animals", :author => "Zebra", :id => nil, :copy_id => 0})
        test_book_2.save()
        test_book_2.make_copy()
        test_book_2.make_copy()
        test_book.make_copy()
        test_patron.check_out(test_book_2)
        test_patron.check_out(test_book_2)
        expect(test_patron.history()).to(eq([test_book_2, test_book_2]))
      end
    end
    describe('#due') do
      it('returns the due date for a book') do
        test_patron = Patron.new({:name => "Samnson", :id => nil})
        test_patron.save()
        test_book = Book.new({:title => "Birds", :author => "Joe", :id => nil, :copy_id => 0})
        test_book.save()
        test_book.make_copy()
        test_book.make_copy()
        test_patron.check_out(test_book)
        expect(test_patron.due(test_book)).to(eq(["5-21-2015"]))  # <----- static date

      end
    end
end
