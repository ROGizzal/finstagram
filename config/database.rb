configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)

  set :database, {
    adapter: "sqlite3",
    database: "db/db.sqlite3"
  }

else
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://gxtmmeubbfkabo:07f08ea6308b251ee8c16d7c6e0d38390f3a07475a524f745aa369e67411383f@ec2-54-235-196-250.compute-1.amazonaws.com:5432/d1ukn0f0crh387
')
  set :database, {
  adapter: "postgresql",
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: "utf8"
  }

end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end
end
