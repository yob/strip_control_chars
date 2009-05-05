Gem::Specification.new do |s|
  s.name              = "strip_control_chars"
  s.version           = "1.0"
  s.summary           = "a small ActiveRecord plugin that removes ASCII control chars from attributes"
  s.description       = "a small ActiveRecord plugin that removes ASCII control chars from attributes"
  s.author            = "James Healy"
  s.email             = "james@yob.id.au"
  s.homepage          = "http://github.com/yob/strip_control_chars/tree/master"
  s.has_rdoc          = true
  s.rdoc_options      << "--title" << "Strip Control Chars" << "--line-numbers"
  s.rubyforge_project = "yob-projects"
  s.test_files        = [ "test/strip_control_chars_test.rb", "test/test_helper.rb" ]
  s.files             = [ "init.rb", "rails/init.rb", "lib/strip_control_chars.rb", "Rakefile", "MIT-LICENSE", "README.rdoc" ]
end
