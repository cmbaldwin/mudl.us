Rails.application.routes.draw do

	devise_for :users, controllers: {
				sessions: 'users/sessions'
			}
	resources :tweets
	get '/tweets/tweet_results/(.:format)' => 'tweets#tweet_results', as: :tweet_results
	post '/tweets/tweet_upload/(.:format)', as: :tweet_upload, to: 'tweets#tweet_upload'
	resources :ohayos

	root 'ohayo#index'

end
