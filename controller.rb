require 'httparty'

req = HTTParty.get("http://127.0.0.1:3000/users")
pp req

