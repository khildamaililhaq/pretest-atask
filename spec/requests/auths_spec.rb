require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'Auths API', type: :request do
  path '/auths/login' do
    post('Login') do
      tags 'Authentications API'
      description('Login with given username and password,
            after Login copy the Token and place in Authorize Form without prefix')

      parameter name: :username, in: :query, type: :string
      parameter name: :password, in: :query, type: :string

      response(200, 'Login Success') do
        before { Entity.create(name: 'Valid', username: 'valid', password: 'valid', pin: '123456') }
        let(:username) { 'valid' }
        let(:password) { 'valid' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Login Failed Wrong Password') do
        let(:username) { 'not_valid_username' }
        let(:password) { 'valid_password' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Login Failed Wrong Username') do
        let(:username) { 'not_a_valid_username' }
        let(:password) { 'valid_password' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/auths/logout' do
    post('Logout') do
      tags 'Authentications API'
      security [ Bearer: {} ]

      response(200, 'Logout Success') do
        let(:Authorization) { generate_token }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Wrong Token') do
        let(:Authorization) { 'invalid_token' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/auths/me' do
    get('Get Entity Detail') do
      tags 'Authentications API'
      security [ Bearer: {} ]

      response(200, 'Success Get Entity Detail') do
        let(:Authorization) { generate_token }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Wrong Token') do
        let(:Authorization) { 'invalid' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
