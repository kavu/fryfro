# http://support.flurry.com/index.php?title=API/Code/AppInfo
module Fryfro
  class AppInfo < Endpoint
    base_uri 'http://api.flurry.com/appInfo'

    class << self
      alias_method :camelize, :camelize_key
    end
  end
end
