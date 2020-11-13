module TestHelper
  def login
    post user_session_path, params: { email: "joao@email.com", password: "12345678" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_tokens(resp)
    client = resp.headers['client']
    token = resp.headers['access-token']
    expiry = resp.headers['expiry']
    token_type = resp.headers['token-type']
    uid = resp.headers['uid']

    {
      "client": client,
      "access-token": token,
      "expiry": expiry,
      "token_type": token_type,
      "uid": uid
    }
  end
end
