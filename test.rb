require 'httparty'

params = { email: "test@email.com", "password": "password" }

# tokens = {"client" =>"8vxxqj2jwEcHlkdVL9Xxbg", "access-token" =>"y-RmNzAO1o1byuzA08ZpCQ", "uid" =>"test@email.com"}

# response = HTTParty.post("http://localhost:3000/auth/sign_in", body: params)

a = { "client" => "Xn-5ZDXCi5OI2Aw4Iu39HQ", "access-token" =>"OFOMBla1MKsMBwWXidsCaA", "uid" =>"test@email.com"}
# delete
response = HTTParty.delete("http://localhost:3000/auth/sign_out", headers: a)

=begin
tokens = {
  "client": response.headers["client"],
  "access-token": response.headers['access-token'],
  "uid": response.headers['uid'], 
}
=end

