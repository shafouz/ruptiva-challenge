require 'swagger_helper'

describe 'Users login API' do

  path '/auth/sign_in' do

    post 'Logs in an user' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :email, in: :query, required: true, type: :string
      parameter name: :password, in: :query, required: true, type: :string

      response '200', 'login user' do
        schema type: :object,
          properties: {
            email: { type: :string }, 
            password: { type: :string },
          },
          required: [ 'email', 'password' ]

        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end

    delete 'Logs out an user' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :client, in: :header, required: true, type: :string 
      parameter name: :token_type, in: :header, required: true, type: :string 
      parameter name: :uid, in: :header, required: true, type: :string 

      response '200', 'logout user' do
        schema type: :object,
          properties: {
            client: { type: :string }, 
            token_type: { type: :string },
            uid: { type: :string },
          },
          required: [ 'client', 'token_type', 'uid' ]

        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end
