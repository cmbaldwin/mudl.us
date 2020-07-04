# mudl.us

* Purpose:
Liberate and give a user control over their personal data from data sharing model SNS (just Twitter for now) and double as a personal landing page.

## specifications
**Enviornment**
* Ruby 2.6.5
* Rails 6.0.0

**dependencies**
* Postgresql
* Heroku (for deployment)
* Twitter Gem

**Configuration**
I use RBENV for ruby version control. 'bundle install/upgrade' and 'yarn install/upgrade' should take care of the rest. 


## deployment
**Database creation/initialization**
Production database is deployed by Heroku.
Development database must be deployed manually (Instructions I used: https://www.guru99.com/postgresql-create-database.html)
Heroku handles the production database. Make sure to include passwords for the respective databases in .env file.

**How to run the test suite**
(Under Development)

**Services (job queues, cache servers, search engines, etc.)**
* Devise (for simple admin authentication, specify admin in .env file)
* Twitter (Backup all favorites and tweets from downloaded archive [tweet.js and like.js, respctively], scrape API every 10 minutes for updates after that.)
* Flickr (for front page photos)

**Future plans for Integration**
* Twitter: User setting to delete scraped tweets, unretweet, and unfavorite after a specific time period (you own your history).
* Instagram/Facebook history integration (same as Twitter).

**Further instructions**
* Standard Heroku Deployment, this can be run on a single web hobby dyno (7 dollars a month) on your own domain. See guide at: https://devcenter.heroku.com/articles/getting-started-with-rails5#deploy-your-application-to-heroku for a good place to start.
* User account creation has been disabled. You'll need to set up the admin account manually through the rails console, i.e.

```ruby
heroku run rails c
irb(main):001:0> admin = User.new
irb(main):001:0> admin.email = '(your e-mail here)'
irb(main):001:0> admin.password = '(your secure password here)'
irb(main):001:0> admin.save
```

* Up and Running:
Once you get the app up and running, you'll need to input some variables into your .env file. 

```ruby
FLICKR_API_KEY=(flickr api key)
FLICKR_USER=(flickr username you use to login)
TWITTER_API_KEY=(twitter dev api key)
TWITTER_API_SECRET=(twitter dev api secret)
TWITTER_ACCESS_TOKEN=(twitter dev api access token)
TWITTER_ACCESS_TOKEN_SECRET=(twitter dev api access token secret)
TWITTER_USER=(your twitter user name)
TWITTER_DEV_BASIC=(your basic dev sandbox env name)
TWITTER_DEV_FULL=(your premium dev sandbox env name)
ADMIN=(admin e-mail here)
```
