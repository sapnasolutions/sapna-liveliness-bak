
module Jzip
  module Engine
    module Support
      module Notifier
    
        def notify(message)
          string = wrap(message)
          RAILS_ENV == "test" ? puts(string) : RAILS_DEFAULT_LOGGER.info(string)
        end
        
      private
        
        def wrap(message)
          "== JZIP: #{message}"
        end
    
      end
    end
  end
end
