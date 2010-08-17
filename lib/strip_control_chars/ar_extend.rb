module StripControlChars
  module ArExtend
    # Strips ASCII control chars from attributes before they get saved
    def strip_control_chars!(options = nil)
      before_validation do |record|
        attributes = StripControlChars::ArExtend.narrow(record.attributes, options)
        attributes.each do |attr, value|
          if value.respond_to?(:tr)
            value = value.tr("\x00\x01\x02\x03\x04\x05\x06\x07\x08","         ")
            value = value.tr("\x0B\x0C\x0E\x0F\x10\x11\x12\x13\x14","         ")
            value = value.tr("\x15\x16\x17\x18\x19\x1A\x1B\x1C\x1D","         ")
            value = value.tr("\x1E\x1F","  ")
            record[attr] = value
          end
        end
      end
    end

    # Necessary because Rails has removed the narrowing of attributes using :only
    # and :except on Base#attributes
    def self.narrow(attributes, options)
      if options.nil?
        attributes
      else
        if except = options[:except]
          except = Array(except).collect { |attribute| attribute.to_s }
          attributes.except(*except)
        elsif only = options[:only]
          only = Array(only).collect { |attribute| attribute.to_s }
          attributes.slice(*only)
        else
          raise ArgumentError, "Options does not specify :except or :only (#{options.keys.inspect})"
        end
      end
    end
  end
end
