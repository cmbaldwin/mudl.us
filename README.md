# mudl.us

* Purpose
	Simple homepage that takes a random flickr image from my photostream and uses it for the background.

# Heroku Default Readme:
* Enviornment
	Ruby 2.6.5
	Rails 6.0.0

* System dependencies
	Postgresql
	Heroku (for deployment)

* Configuration
	RBENV for ruby version control. 'bundle install/upgrade' and 'yarn install/upgrade' should take care of the rest. 

* Database creation/initialization
	Production database is deployed by Heroku
	Development database must be deployed manually (Instructions I used: https://www.guru99.com/postgresql-create-database.html)
	Heroku the handles production database. Make sure to include passwords for the respective databases in .env file.

* How to run the test suite
	Standard Ruby test suite. (Under development)

* Services (job queues, cache servers, search engines, etc.)
	Twitter (for scraping--use Scheduler to schedule the task)
	Devise (for simple admin authentication, specify admin in .env file)

* Deployment instructions
	Standard Heroku Deployment, see guide at: https://devcenter.heroku.com/articles/getting-started-with-rails5#deploy-your-application-to-heroku