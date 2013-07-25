Rails.application.routes.draw do
  post '/blog/post_blog' => 'blog/blogs#post_blog', :as => :post_blog
end
