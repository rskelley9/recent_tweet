

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by_name(params[:username])
  
    if stale?(@user.updated_at)
      @user.tweets.destroy_all
    end 

    if @user.tweets.empty?
      @tweets = Twitter.user_timeline(params[:username])
      @tweets.each do |eachtweet|
        Tweet.create(tweet_text: eachtweet.text, twitter_user_id: @user.id)  
      end 
        erb :tweet_new 
    else 
        @tweets = @user.tweets.limit(3)  
        erb :tweet
    end 
end 

post '/tweet' do 
  Twitter.update(params[:tweet])
end 
