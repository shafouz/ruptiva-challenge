require 'swagger_helper'

describe 'Users API' do

  path '/auth' do

    post 'Creates an user' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :email, in: :query, required: true, type: :string
      parameter name: :password, in: :query, required: true, type: :string
      parameter name: :password_confirmation, in: :query, required: true, type: :string
      parameter name: :first_name, in: :query, required: true, type: :string
      parameter name: :last_name, in: :query, required: true, type: :string

      response '200', 'creates user' do
        schema type: :object,
          properties: {
            email: { type: :string }, 
            password: { type: :string },
            password_confirmation: { type: :string },
            first_name: { type: :string },
            last_name: { type: :string }
          },
          required: [ 'email', 'password', 'password_confirmation', 'first_name', 'last_name' ]

          run_test!
      end

      response '422', 'unprocessable entity' do
        run_test!
      end

    end

    patch 'Updates an user data' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :email, in: :query, required: false, type: :string
      parameter name: :password, in: :query, required: true, type: :string
      parameter name: :password_confirmation, in: :query, required: true, type: :string
      parameter name: :first_name, in: :query, required: false, type: :string
      parameter name: :last_name, in: :query, required: false, type: :string

      parameter name: :client, in: :query, required: true, type: :string 
      parameter name: :token_type, in: :query, required: true, type: :string 
      parameter name: :uid, in: :query, required: true, type: :string 

      response '200', 'updates user' do
        schema type: :object,
          properties: {
            email: { type: :string }, 
            password: { type: :string },
            password_confirmation: { type: :string },
            first_name: { type: :string },
            last_name: { type: :string },

            uid: { type: :string },
            token_type: { type: :string },
            client: { type: :string }
          },
          required: [ 'password', 'password_confirmation', 'uid', 'token_type', 'client' ]

          run_test!
      end

      response '404', 'not found' do
        run_test!
      end
    end

    delete 'Soft-deletes an user' do

      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :client, in: :query, required: true, type: :string 
      parameter name: :token_type, in: :query, required: true, type: :string 
      parameter name: :uid, in: :query, required: true, type: :string 

      response '200', 'deletes an user' do
        schema type: :object,
          properties: {
            uid: { type: :string },
            token_type: { type: :string },
            client: { type: :string }
          },
          required: [ 'uid', 'token_type', 'client' ]

          run_test!
      end

      response '404', 'not found' do
        run_test!
      end
    end

  end
end
