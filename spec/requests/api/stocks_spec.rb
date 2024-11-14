require 'rails_helper'
require 'swagger_helper'

RSpec.describe "Api::Stocks", type: :request do
  path '/api/stocks' do
    get 'Show Stock Detail' do
      tags 'Stocks Api'
      security [ Bearer: {} ]
      response(200, 'Success Response') do
        let(:Authorization) { generate_stock_token }
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

  path '/api/stocks/transfer' do
    post('Transfer money to another Entity') do
      tags 'Stocks Api'
      consumes 'application/json'
      security [ Bearer: {} ]
      parameter name: :wallet_transaction,
                description: 'Detail Wallet Transaction',
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    wallet_transaction: {
                      type: :object,
                      properties: {
                        entity_id: { type: :integer },
                        amount: { type: :integer },
                        pin: { type: :string }
                      }
                    }
                  }
                }

      response(200, 'Transfer Success') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: generate_stock.id, amount: 1000, pin: '123456' } } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'Insufficient Balance') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: generate_stock.id, amount: 1_000_000, pin: '123456' } } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(412, 'Precondition Failed, Params Missing of Wrong') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: generate_stock.id, amount: -1000, pin: '123456' } } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Precondition Failed, Destination Entity Didnt exist') do
        let(:Authorization) { generate_team_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: -2, amount: 1000, pin: '123456' } } }
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
        let(:wallet_transaction) { { wallet_transaction: { entity_id: generate_stock.id, amount: 1000, pin: '123456' } } }
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

  path '/api/stocks/deposit' do
    post('Deposit Money to current account') do
      consumes 'application/json'
      tags 'Stocks Api'
      security [ Bearer: {} ]
      parameter name: :wallet_transaction,
                description: 'Detail Wallet Transaction',
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    wallet_transaction: {
                      type: :object,
                      properties: {
                        amount: { type: :integer },
                        pin: { type: :string }
                      }
                    }
                  }
                }

      response(200, 'Transfer Success') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: nil, amount: 1000, pin: '123456' } } }
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
        let(:Authorization) { 'invalid' }
        let(:wallet_transaction) { { entity_id: nil, amount: 1000 } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(412, 'Precondition failed, amount minus') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: nil, amount: -1000, pin: '123456' } } }
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

  path '/api/stocks/withdraw' do
    post('Withdraw Money to current account') do
      consumes 'application/json'
      tags 'Stocks Api'
      security [ Bearer: {} ]
      parameter name: :wallet_transaction,
                description: 'Detail Wallet Transaction',
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    wallet_transaction: {
                      type: :object,
                      properties: {
                        amount: { type: :integer },
                        pin: { type: :string }
                      }
                    }
                  }
                }

      response(200, 'Withdraw Success') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: nil, amount: 100, pin: '123456' } } }
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
        let(:Authorization) { 'invalid' }
        let(:wallet_transaction) { { entity_id: nil, amount: 1000, pin: '123456' } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Withdraw Failed Wrong PIN') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: nil, amount: 100, pin: '12456' } } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(412, 'Precondition failed, amount minus, Withdraw Failed') do
        let(:Authorization) { generate_stock_token }
        let(:wallet_transaction) { { wallet_transaction: { entity_id: nil, amount: -1000, pin: '123456' } } }
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
