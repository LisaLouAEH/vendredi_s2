# ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter
require 'dotenv'
require 'httparty'
require 'base64'
Dotenv.load
#definir une methode authentification pour connecter notre API a spotify
#(sauf qu'on pas encore de clefs API)
#etape 1 //
def encoding(id, secret)
    #chercher a quoi correspond la methode .strict
    #.strict_encode64 sert a crypter les données dans un type particulier
    #appelé Base64
    #mettre un 'Basic espace' a l'interieur de la string
    return "Basic " + (Base64.strict_encode64("#{id}:#{secret}"))
end

def post 
    #on declare une variable post qui prend en param : 
    # l'URL en string
    # un hash header
    #et un hash body
    # ne pas oublier les virgules entre les differents parametre
    post_request = HTTParty.post(
        url = "https://accounts.spotify.com/api/token", 
  headers: {
        "Authorization" => encoding(ENV["id_client"], ENV["secret_client"])
    }, 
  body: {
      "grant_type" => "client_credentials"
    })
    
    return post_request["access_token"]
end
@token = post
puts post
def wtf
    get_request = HTTParty.get(
        url = "https://api.spotify.com/v1/browse/new-releases",
        headers: {
        "Authorization" => "Bearer #{@token}"})
    return get_request
end
puts wtf