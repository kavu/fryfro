# http://support.flurry.com/index.php?title=API/Code/RawData
# The RawData API allows you to request a dump of raw session data for one of your applications over
# a specified time period. Note that this API requires special permissions so please contact flurry
# support (support@flurry.com) or talk to your Flurry Account Manager for more information.

# TODO: Implement the Request Report feature, and then publish
module Fryfro
  class RawData < Endpoint
    base_uri 'http://api.flurry.com/rawData'
  end
end
