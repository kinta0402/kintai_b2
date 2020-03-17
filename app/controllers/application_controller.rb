class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper # 親contに先を記載する事で、どのcontでも定義したメソッドが使える 6.3
end
