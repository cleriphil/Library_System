class Book

  attr_reader(:author, :title, :id)

  define_method(:initialize) do |attributes|
    @author = attributes.fetch(:author)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end
end
