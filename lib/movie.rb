require 'pry'

class Movie
  attr_accessor :title, :release_date, :director, :summary

  @@movies = []

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary
    @@movies << self
  end

  def url
    sanitized = @title.downcase.gsub(" ", "_")
    "#{sanitized}.html"
  end

  def self.all
    @@movies
  end

  def self.reset_movies!
    @@movies.clear
  end

  def self.make_movies!
    file = File.read('spec/fixtures/movies.txt')
    movie_array = file.split(/\n/)
    movie_attributes = movie_array.map do |movie|
      movie.split(" - ")
    end

    movie_attributes.map do |a|
        Movie.new(a[0], a[1].to_i, a[2], a[3])
    end
  end

  def self.recent
    recent_movies = @@movies.select {|m| m.release_date >= 2012}
    recent_movies
  end
end
