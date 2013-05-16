require 'rake/tasklib'
require 'xcodebuild'

module XcodeUtils

  class BuildPathHandler

    attr_reader :build_path

    def <<(line)
      match = line.match(/setenv BUILT_PRODUCTS_DIR (?<build_path>.*)/)
      @build_path = match['build_path'] if match
    end
  end

  class XcodeTask < ::Rake::TaskLib
    include Rake::DSL if defined?(Rake::DSL)

    attr_reader :project_name, :scheme_name, :bundle_path

    def initialize(project_name, scheme_name:nil, family:nil)
      @project_name = project_name
      @scheme_name  = scheme_name ? scheme_name : project_name
      @family       = family

      define
    end

    def build(configuration=:debug, clean=false, clang_db=false)
      formatter     = XcodeBuild::Formatters::ProgressFormatter.new
      reporter      = XcodeBuild::Reporter.new(formatter)
      output_buffer = XcodeBuild::OutputTranslator.new(reporter)
      path_handler  = BuildPathHandler.new
      reporter.direct_raw_output_to = path_handler

      arguments = []
      arguments << "-workspace #{Dir.pwd}/#{@project_name}.xcworkspace"
      arguments << "-scheme #{@scheme_name}"
      arguments << '-sdk iphonesimulator'
      arguments << "-configuration #{configuration == :release ? 'Release' : 'Debug'}"
      arguments << 'ONLY_ACTIVE_ARCH=NO'
      arguments << 'clean' if clean
      arguments << "build"
      arguments << "| ~/.dotfiles/scripts/clang_db.rb" if clang_db

      XcodeBuild.run(arguments.compact.join(' '), clang_db ? STDOUT : output_buffer)
      @bundle_path = "#{path_handler.build_path}/#{scheme_name}.app"
    end

    def run_on_simulator(family=nil)
      arguments = []
      arguments << "--family #{family}" if family
      arguments << "--exit --verbose"
      system("ios-sim launch #{@bundle_path} " + arguments.join(' '))
    end

    def attach_lldb
      raise 'Project should be build first' unless @bundle_path
      system("lldb -n #{@bundle_path}/#{@scheme_name}") 
    end

    def define
      desc 'Build project'
      task :xcode_build do
        build
      end

      desc 'Run build on iphone simulator'
      task :simulator => :xcode_build do
        run_on_simulator(@family)
      end

      desc 'Run build and attach process to lldb'
      task :lldb => :simulator do
        attach_lldb
      end

      desc 'Create compile_commands.json'
      task :clang_db do
        build(:debug, true, true)
      end
    end
  end
end
