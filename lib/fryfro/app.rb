module Fryfro
  class App
    attr_reader :key, :access_code, :name, :platform, :created_at

    def initialize(opts = {})
      # Mandatory
      @access_code = opts[:access_code] or raise ArgumentError, 'Provide an apiAccessCode'
      @key         = opts[:key]         or raise ArgumentError, 'Provide an apiKey'

      # Optional
      @name       = opts[:name]
      @platform   = opts[:platform]
      @created_at = opts[:created_at]
    end

    def info
      AppInfo[:get_application].(@access_code, @key)['appInfo']
    end

    def metric(metric, opts = {})
      raise ArgumentError, 'Provide an eventName' unless metric
      check_required_dates(opts)
      AppMetrics[metric].(@access_code, @key, opts)['appMetrics']
    end

    def events(opts = {})
      check_required_dates(opts)
      EventMetrics[:summary].(@access_code, @key, opts)['eventMetrics']
    end

    def event(opts = {})
      raise ArgumentError, 'Provide an eventName' unless opts[:event_name] || opts['eventName']
      check_required_dates(opts)
      EventMetrics[:event].(@access_code, @key, opts)['eventMetrics']
    end

    def raw_data(opts = {})
      check_params_overlap(opts)
      time_params?(opts) ? check_required_times(opts) : check_required_dates(opts)
      RawData[:events].(@access_code, @key, opts)
    end

    private
      def check_required_dates(opts)
        raise ArgumentError, 'Provide an startDate' unless opts[:start_date] || opts['startDate']
        raise ArgumentError, 'Provide an endDate'   unless opts[:end_date]   || opts['endDate']
      end

      def check_required_times(opts)
        raise ArgumentError, 'Provide an startTime' unless opts[:start_time] || opts['startTime']
        raise ArgumentError, 'Provide an endTime'   unless opts[:end_time]   || opts['endTime']
      end

      def check_params_overlap(opts)
        start_param = (opts[:start_date] || opts['startDate']) && (opts[:start_time] || opts['startTime'])
        end_param   = (opts[:end_date]   || opts['endDate'])   && (opts[:end_time]   || opts['endTime'])
        raise ArgumentError, 'Provide a startDate/endDate or a startTime/endTime only' if start_param || end_param
      end

      def time_params?(opts)
        opts[:start_time] || opts['startTime'] || opts[:end_time] || opts['endTime']
      end
  end
end
