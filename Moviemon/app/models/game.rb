require 'net/http'
require 'json'


class Game

  MOVIE_LIST = [
    'tt0368226',
    'tt1663662',
    'tt0088763',
    'tt1371111',
    'tt0120611',
    'tt1136608',
    'tt0486640',
    'tt1855325',
    'tt0113855',
    'tt0811080',
    ]

  # initialiser une partie
  def initialize
  end

  # charger une partie enregistrée
  def load
    file = File.read("/tmp/backup.json")
    data_hash = JSON.parse(file, :symbolize_names => true)
    $player = data_hash[$player[:slot] - 1]
  end

  # sauvegarder une partie
  def save
    unless File.exist?("/tmp/backup.json")
      File.open("/tmp/backup.json", "w+") do |f|
        tab = [{}, {}, {}]
        tab[$player[:slot] - 1] = $player
        f.write(JSON.pretty_generate(tab))
      end
    else
      tab = JSON.parse(File.read("/tmp/backup.json"))
      File.open("/tmp/backup.json", "w+") do |f|
        tab[$player[:slot] - 1] = $player
        f.write(JSON.pretty_generate(tab))
      end
    end
  end

  # chargement des movies définis dans movie_list
  def load_movies
    movies = MOVIE_LIST.map {|movie|
      url = URI.parse("http://www.omdbapi.com/?i=#{movie}&apikey=fe540c06")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      data = res.body
      data = JSON.parse(data)
      movie = {
          name: data['Title'],
          strength: (data['imdbRating'].to_f).to_i,
          rating: data['imdbRating'],
          life: (data['imdbRating'].to_f * 10).to_i,
          actors: data['Actors'],
          year: data['Year'],
          image: data['Poster'],
          director: data['Director'],
          catched: false,
      }
    }
  end


end

