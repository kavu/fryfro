require 'fryfro/version'

require 'fryfro/endpoint'
require 'fryfro/app_info'
require 'fryfro/app_metrics'
require 'fryfro/events_metrics'
require 'fryfro/raw_data'

require 'fryfro/app'

module Fryfro
  class << self
    def all_applications_info_raw(opts = {})
      AppInfo[:get_all_applications].(opts[:access_code])['applications']
    end

    def all_applications(opts = {})
      raw = all_applications_info_raw(opts)['application']

      raw.reduce([]) do |apps, app|
        apps << App.new(key: app['apiKey'], access_code: opts[:access_code],
                        name: app['name'], platform: app['platform'],
                        created_at: app['createdDate'])
      end
    end
  end
end
