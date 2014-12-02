require 'berkflow/thor_tasks'

begin
  require 'kitchen/thor_tasks'
  Kitchen::ThorTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
 
class Cookbook < Thor
  include Thor::Actions
 
  require 'mixlib/shellout'

  PKG_DIR = File.expand_path("./pkg").freeze
  COOKBOOK_NAME = Ridley::Chef::Cookbook.from_path(File.dirname("Berksfile")).name
  COOKBOOK_SHORT_NAME = Ridley::Chef::Cookbook.from_path(File.dirname("Berksfile")).to_hash[:cookbook_name]
  COOKBOOK_VERSION = Ridley::Chef::Cookbook.from_path(File.dirname("Berksfile")).version
  ARTIFACT_NAME = "#{COOKBOOK_NAME}-cookbook.tar.gz"
  REPOSITORY = "todo"


  # test commands

  desc 'test_all', 'runs ALL the tests (lint, foodcritic, unit, integration)'
  def test_all
    invoke 'test'
    invoke 'int_test'
  end

  desc 'lint', "lint check (L'Apéritif)"
  def lint
    puts "running lint tests (L'Apéritif)"
    l = Mixlib::ShellOut.new("rubocop")
    l.run_command
    puts l.stdout
    raise "lint check failed" if l.exitstatus > 0
  end

  desc 'foodcritic', 'run foodcritic (Amuse-bouche)'
  def foodcritic
    puts "running foodcritic (Amuse-bouche)"
    f = Mixlib::ShellOut.new('foodcritic -f any --tags ~FC001 --tags ~FC019 --tags ~FC047 .')
    f.run_command
    puts f.stdout
    raise "Foodcritic failed" if f.exitstatus > 0
  end

  desc 'unit', "run unit tests (L'Entrée)"
  def unit
    puts "running unit tests (L'Entrée)"
    f = Mixlib::ShellOut.new('rspec --color')
    f.run_command
    puts f.stdout
    puts f.stderr
    raise "unit tests failed" if f.exitstatus > 0
  end 
 
  desc 'test', 'Run all the quick tests (lint, foodcritic, unit)'
  def test
    lint
    foodcritic
    unit
 #   invoke 'kitchen:all'
  end

  desc 'int_test', 'Run all the integration tests (Le Plat Principal)'
  #  we will converge and test twice.  The first time would be a new instance
  #  but the 2nd time would test that a re-convergance on an exiting instance also works
  def int_test
    say "we converge/test twice to make sure both a new instance and an existing instance pass the tests (Le Plat Principal)"

    # NOTE: we have to use run because thor kitchen tasks if invoked locally will remember last state so
    #       you can not verify twice that way!!
    say 'setup (mis en place)...destroy the kitchen if one already exists'
    run 'thor kitchen:c_l_i:destroy'
    begin 
      say 'testing with new vm converge...'
      converge_and_ver
      say 'testing with existing vm converge...'
      converge_and_ver
    ensure
      # clean up
      say 'cleanup the kitchen...'
      run 'thor kitchen:c_l_i:destroy'
    end  
  end

# end test commands

# packaging commands
  desc 'clean', 'clean the packaging directory'
    def clean
      say "cleaning..."
      [ PKG_DIR ].each do |dir|
        FileUtils.rm_rf(dir)
      end
    end

  desc 'package', 'packages the cookbook (Le Dessert)'
    def package
      say 'packaging (Le Dessert)'
      invoke "clean"
      say "packaging #{COOKBOOK_NAME}"
      berksfile = Berkshelf::Berksfile.from_file("Berksfile")
      out_file = File.join(PKG_DIR, ARTIFACT_NAME)
      FileUtils.mkdir_p(PKG_DIR)
      berksfile.package(out_file)
    end

# desc 'upload USER PASSWORD [REPOSITORY]', 'uploads cookbook artifact to artifact repository (Le Digestif)'
#     def upload(user, password, repo=REPOSITORY)
#       invoke "package", []
#       say 'uploading artifact to the repository (Le Digestif)'
#       # TODO: upload to github repo
#       up = Mixlib::ShellOut.new("curl -v -u #{user}:#{password} --upload-file '#{PKG_DIR}/#{ARTIFACT_NAME}' #{repo}/#{COOKBOOK_SHORT_NAME}/#{COOKBOOK_VERSION}/#{ARTIFACT_NAME}")
#      up.run_command
#      raise "upload of artifact failed" if up.exitstatus > 0
#      say "uploaded cookbook atrifact #{ARTIFACT_NAME} to #{repo}"
#      say "url is #{repo}/#{COOKBOOK_SHORT_NAME}/#{COOKBOOK_VERSION}/#{ARTIFACT_NAME}"
#    end

# end packaging commands
 
  private
    def converge_and_ver
      say 'doing converge (cooking)...'
      run 'thor kitchen:c_l_i:converge'
      say 'running kitchen tests (eating)...'
      kv = Mixlib::ShellOut.new('thor kitchen:c_l_i:verify')
      begin
        kv.run_command
        puts kv.stdout
        raise "integration tests failed" if kv.exitstatus > 0
      end
    end
end

