# Load files from db/seeds in alphabetical order
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

