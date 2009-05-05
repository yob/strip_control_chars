require "#{File.dirname(__FILE__)}/test_helper"

module MockAttributes
  def self.included(base)
    base.column :foo, :string
    base.column :bar, :string
    base.column :biz, :string
    base.column :baz, :string
  end
end

class ConvertAllMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_control_chars!
end

class ConvertOnlyOneMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_control_chars! :only => :foo
end

class ConvertOnlyThreeMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_control_chars! :only => [:foo, :bar, :biz]
end

class ConvertExceptOneMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_control_chars! :except => :foo
end

class ConvertExceptThreeMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_control_chars! :except => [:foo, :bar, :biz]
end

class DumbQuotesTest < Test::Unit::TestCase
  def setup
    @init_params = { :foo => "foo\x00", :bar => "bar\x07", :biz => "biz\x09", :baz => "baz\x1E" }
  end

  def test_should_exist
    assert Object.const_defined?(:StripControlChars)
  end

  def test_should_fix_all_fields
    record = ConvertAllMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo ", record.foo
    assert_equal "bar ", record.bar
    assert_equal "biz\x09", record.biz
    assert_equal "baz ", record.baz
  end

  def test_should_convert_only_one_field
    record = ConvertOnlyOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo ", record.foo
    assert_equal "bar\x07", record.bar
    assert_equal "biz\x09", record.biz
    assert_equal "baz\x1E", record.baz
  end

  def test_should_convert_only_three_fields
    record = ConvertOnlyThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo ", record.foo
    assert_equal "bar ", record.bar
    assert_equal "biz\x09", record.biz
    assert_equal "baz\x1E", record.baz
  end

  def test_should_convert_all_except_one_field
    record = ConvertExceptOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo\x00", record.foo
    assert_equal "bar ", record.bar
    assert_equal "biz\x09", record.biz
    assert_equal "baz ", record.baz
  end

  def test_should_convert_all_except_three_fields
    record = ConvertExceptThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo\x00", record.foo
    assert_equal "bar\x07", record.bar
    assert_equal "biz\x09", record.biz
    assert_equal "baz ", record.baz
  end
end
