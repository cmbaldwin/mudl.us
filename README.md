# mudl.us

* Enviornment
	Ruby 2.5.1
	Rails 6.0.0

* System dependencies
	Postgresql
	Heroku (for deployment)

* Configuration
	I used rbenv for ruby version control. 'bundle install' should take care of the rest. 

* Database creation/initialization
	Production database is deployed by Heroku
	Development database must be deployed manually (Instructions I used: https://www.guru99.com/postgresql-create-database.html)
	Create a database with 'psql' with the name "mudl_us_development" for development mode, and "mudl_us_test" for tests. Heroku the handles production database. Make sure to include passwords for the respective databases in our .env file. Variables used in the config/database.yml file are "DEV_DB_PASSWORD" and "TEST_DB_PASSWORD", respectively.

* How to run the test suite
	Standard Ruby test suite. (Under development)

* Services (job queues, cache servers, search engines, etc.)
	None currently (in progress)

* Deployment instructions
	Standard Heroku Deployment, see guide at: https://devcenter.heroku.com/articles/getting-started-with-rails5#deploy-your-application-to-heroku