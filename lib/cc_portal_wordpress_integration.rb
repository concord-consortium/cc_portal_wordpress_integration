require "cc_portal_wordpress_integration/engine"
require "wordpress"
require "cgi"

module CcPortalWordpressIntegration

  Warden::Manager.after_authentication do |user, warden, options|
    cookies = warden.cookies
    params = warden.params
    request = warden.request

    delete_wordpress_cookies cookies, request
    begin
      # log in to the blog
      resp = Wordpress.new.log_in_user(user.login, params[:user][:password])

      # capture the cookies set by the blog
      # and set those cookies in our current domain
      #   cookies match: wordpress_* and wordpress_logged_in_*
      resp['Set-Cookie'].split(/[,\;] |\n/).each do |token|
        k,v = token.split("=")
        if k.to_s =~ /^wordpress_/
          cookies[k.to_sym] = {:value => CGI::unescape(v), :domain => cookie_domain(request) }
        end
      end
    rescue
      # FIXME How do we handle a login failure?
    end
  end

  Warden::Manager.before_logout do |user, warden, options|
    delete_wordpress_cookies warden.cookies, warden.request
  end

  def delete_wordpress_cookies(cookies, request)
    # cookies match: wordpress_* and wordpress_logged_in_*
    cookies.each do |key, val|
      if key.to_s =~ /^wordpress_/
        if cookies.kind_of? ActionDispatch::Cookies::CookieJar
          cookies.delete(key, {:domain => cookie_domain(request)})
        else
          cookies.delete key
        end
      end
    end
  end

  def cookie_domain(request)
    # use wildcard domain (last two parts ".concord.org") for this cookie
    cookie_domain = request.host
    cookie_domain = '.concord.org' if @cookie_domain =~ /\.concord\.org$/

    return cookie_domain
  end

end
