require 'swagger_helper'

describe 'Getting users API' do

  path '/user' do

    get 'Show current logged in user' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :client, in: :header, required: true, type: :string 
      parameter name: :token_type, in: :header, required: true, type: :string 
      parameter name: :uid, in: :header, required: true, type: :string 

      response '200', 'get current_user data' do
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

  path '/users' do

    get 'Show all users, admin only' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :client, in: :header, required: true, type: :string 
      parameter name: :token_type, in: :header, required: true, type: :string 
      parameter name: :uid, in: :header, required: true, type: :string 

      response '200', 'get current_user data' do
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

  path '/admin/user' do

    get 'Gets an user by email, admin only' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :email, in: :header, required: true, type: :string 
      parameter name: :client, in: :header, required: true, type: :string 
      parameter name: :token_type, in: :header, required: true, type: :string 
      parameter name: :uid, in: :header, required: true, type: :string 

      response '200', 'get current_user data' do
        schema type: :object,
          properties: {
            email: { type: :string },
            client: { type: :string }, 
            token_type: { type: :string },
            uid: { type: :string },
          },
          required: [ 'email', 'client', 'token_type', 'uid' ]

        run_test!
      end

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end
