require_relative 'movie.rb'
require 'pry'

class SiteGenerator

  def make_index!
    file = File.open('_site/index.html', "w")
    write_head(file)

    Movie.all.each do |movie|
      # <li><a href="movies/the_matrix.html">The Matrix</a></li>
      x = file.write(
        "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>\n"
      )
    end
    write_end(file)
    file.close
  end

  def write_head(file)
    file.write("<!DOCTYPE html>
    <html>
      <head>
        <title>Movies</title>
      </head>
      <body>
        <ul>")
  end

  def write_end(file)
    file.write("</ul>
      </body>
    </html>")
  end

  def generate_pages!
    Dir.mkdir "_site/movies" unless File.exist? "_site/movies"

    template = File.read('lib/templates/movie.html.erb')
    erb = ERB.new(template)

    Movie.all.each do |movie|
      movie_page = erb.result(binding)
      File.open("_site/movies/#{movie.url}", "w") { |f| f.write(movie_page)}
    end
  end
end
