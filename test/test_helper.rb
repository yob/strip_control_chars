require 'test/unit'
require 'rubygems'
require 'active_record'

PLUGIN_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

$LOAD_PATH.unshift "#{PLUGIN_ROOT}/lib"
require 'strip_control_chars'

class ActiveRecord::Base
  alias_method :save, :valid?
  extend StripControlChars::ArExtend
  def self.columns()
    @columns ||= []
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    @columns ||= []
    @columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type, null)
  end
end
