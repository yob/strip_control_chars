require 'strip_control_chars'
require 'rails'

module StripControlChars
  class Railtie < Rails::Railtie

    initializer "strip_control_chars.active_record" do |app|
      if defined?(::ActiveRecord)
        ::ActiveRecord::Base.extend(StripControlChars::ArExtend)

      end
    end

  end
end
