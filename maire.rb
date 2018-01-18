require 'rubygems'
require 'nokogiri'
require 'open-uri'

#methode qui renvoie une array des urls de chaque mairie
def get_all_the_urls_of_val_doise_townhalls()
  urls_town = []
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    doc.css('a.lientxt').each do |x|
      lien_page_mairie = x['href']
      lien_page_mairie.slice!(0)
      lien_page_mairie = "http://annuaire-des-mairies.com" + lien_page_mairie
      urls_town.push(lien_page_mairie)
    end
  return urls_town
end

#methode qui retorune l'email de contact sur la page d'un commune
def get_the_email_of_a_townhal_from_its_webpage(lien)
  doc = Nokogiri::HTML(open("#{lien}"))
  email = doc.css('html body tr[4] td.style27 p.Style22 font')[1]
end

#methode qui retourne une array avec la liste des noms de communes
def towns_names()
  town_names = []
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    doc.css('a.lientxt').each do |x|
    names = x.text
    names.downcase!
    town_names.push(names)
  end
  return town_names
end

#call les deux variables pour le hash
town_names = towns_names()
urls_town = get_all_the_urls_of_val_doise_townhalls()

#Hash qui retourne :nom de la ville et :son email
list_town = Hash.new
  i = 0
    while i < town_names.length
      url_of_town = urls_town[i]
      town_names = town_names[i]
      list_town[town_names] = get_the_email_of_a_townhal_from_its_webpage(url_of_town)
      i += 1
    end

puts list_town

#malgre tout les efforts il semblerai que mon code ne marche pas...
