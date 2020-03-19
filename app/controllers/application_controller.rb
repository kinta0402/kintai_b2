class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper # 親contに先を記載する事で、どのcontでも定義したメソッドが使える 6.3
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
end
