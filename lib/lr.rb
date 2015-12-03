$LOAD_PATH.push(File.dirname(__FILE__))

require 'fileutils'
require 'digest/sha1'
require 'zlib'

require 'rubygems'
require 'differ'
require 'colorize'

require 'lr/blob'
require 'lr/commit'
require 'lr/tree'

require 'lr/cli'
require 'lr/diff'
require 'lr/log'
require 'lr/repo'

class Lr
  class << self
    attr_accessor :cli
  end

  def self.go(args)
    @cli = Lr::CLI.new(args)
    @cli.execute
  end
end
