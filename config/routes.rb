Rails.application.routes.draw do

	devise_for :users, controllers: {
				sessions: 'users/sessions'
			}

	resources :ohayos

	root 'ohayo#index'

	resources :tweets do
		collection do
			post 'display/(.:format)', as: :display, to: 'tweets#display_change'
		end
	end
		get 'tweets/tweet_results/(.:format)' => 'tweets#tweet_results', as: :tweet_results
		post 'tweets/tweet_upload/(.:format)', as: :tweet_upload, to: 'tweets#tweet_upload'

	resources :likes do
		collection do
			post 'display/(.:format)', as: :display, to: 'likes#display_change'
		end
	end
		get 'likes/like_results/(.:format)' => 'likes#like_results', as: :like_results
		post 'likes/like_upload/(.:format)', as: :like_upload, to: 'likes#like_upload'

end
