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
end
