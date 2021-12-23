# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          template: {
            type: :object,
            properties: {
              type: { type: :string },
              id: { type: :string },
              attributes: {
                type: :object,
                properties: {
                  name: { type: :string },
                  content: { type: :string },
                  create_at: { type: :string },
                  update_at: { type: :string }
                }
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'http://localhost:3000',
          variables: {
            defaultHost: {
              default: 'http://localhost:3000'
            }
          }
        }
      ]
    }
  }
  config.swagger_format = :yaml
end
