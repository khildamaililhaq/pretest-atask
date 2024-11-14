require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'Entities Spec', type: :request do
  path '/entities' do
    get('Get Index for Entity') do
      tags 'Entities Api'
      parameter name: :name, in: :query, type: :string
      security [ Bearer: {} ]

      response(200, 'Search name') do
        let(:Authorization) { generate_token }
        let(:name) { 'valid' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Login Failed Wrong Token') do
        let(:Authorization) { 'invalid_token' }
        let(:name) { 'valid' }
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
