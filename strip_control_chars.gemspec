Gem::Specification.new do |s|
  s.name              = "strip_control_chars"
  s.version           = "2.1"
  s.summary           = "a small ActiveRecord plugin that removes ASCII control chars from attributes"
  s.description       = "a small ActiveRecord plugin that removes ASCII control chars from attributes"
  s.author            = "James Healy"
  s.email             = "james@yob.id.au"
  s.homepage          = "http://github.com/yob/strip_control_chars"
  s.has_rdoc          = true
  s.rdoc_options      << "--title" << "Strip Control Chars" << "--line-numbers"
  s.rubyforge_project = "yob-projects"
  s.test_files        = [ "test/strip_control_chars_test.rb", "test/test_helper.rb" ]
  s.files             = [ "lib/strip_control_chars.rb", "lib/strip_control_chars/ar_extend.rb","lib/strip_control_chars/railtie.rb","Rakefile", "MIT-LICENSE", "README.rdoc" ]
  s.add_dependency("activerecord", ">= 3.0.0")
end
