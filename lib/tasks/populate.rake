namespace :populate do
  include FactoryBot::Syntax::Methods if Rails.env.development?
  desc 'Populate templates'
  task templates: :environment do
    create_list(:template, 20).each do |template|
      puts "template: #{template.id} #{template.name}"
    end
  end
end
