require 'strip_control_chars'
ActiveRecord::Base.extend(StripControlChars)
