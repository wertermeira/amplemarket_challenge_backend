require 'swagger_helper'

RSpec.describe 'templates', type: :request do
  path '/templates' do
    get 'List all templates' do
      let(:templates_count) { rand(1..10) }
      before do
        create_list(:template, templates_count)
      end
      tags 'Templates'
      produces 'application/json'

      response '200', 'templates found' do
        schema type: :object, properties: {
          data: { type: :array, items: { '$ref' => '#/components/schemas/template' } }
        }
        run_test! do
          expect(json_body.dig('data').length).to eq(templates_count)
        end
      end
    end

    post 'Create a template' do
      tags 'Templates'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :template, in: :body, schema: {
        type: :object,
        properties: {
          template: {
            type: :object,
            properties: {
              name: { type: :string },
              content: { type: :string }
            },
            required: %w[name content]
          }
        }
      }

      response '201', 'template created' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/template' } }
        let(:template) { { template: { name: 'test', content: 'test' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:template) { { template: { name: '', content: 'test' } } }
        run_test!
      end
    end
  end

  path '/templates/{id}' do
    get 'Retrieve a template' do
      tags 'Templates'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'template found' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/template' } }

        let(:id) { create(:template).id }
        run_test!
      end

      response '404', 'template not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Update a template' do
      tags 'Templates'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :template, in: :body, schema: {
        type: :object,
        properties: {
          template: {
            type: :object,
            properties: {
              name: { type: :string },
              content: { type: :string }
            },
            required: %w[name content]
          }
        }
      }

      response '202', 'template updated' do
        schema type: :object, properties: { data: { '$ref' => '#/components/schemas/template' } }
        let(:name) { Faker::Internet.name }
        let(:id) { create(:template).id }
        let(:template) { { template: { name: name, content: 'test' } } }
        run_test! do
          expect(json_body.dig('data', 'attributes', 'name')).to eq(name)
        end
      end

      response '404', 'template not found' do
        let(:id) { 'invalid' }
        let(:template) { { template: { name: 'test', content: 'test' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:template).id }
        let(:template) { { template: { name: '', content: 'test' } } }
        run_test!
      end
    end

    delete 'Delete a template' do
      tags 'Templates'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'template deleted' do
        let(:template) { create(:template) }
        let(:id) { template.id }
        run_test! do
          expect(Template.find_by(id: id)).to be_nil
        end
      end

      response '404', 'template not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
