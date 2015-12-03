class Lr
  class CLI
    attr_reader :args, :cwd, :repo, :command

    COMMANDS = %w(init log commit checkout show)

    ZLIB_ON = true

    def initialize(args)
      @args = args
      @cwd = Dir.pwd
      @command = args.shift
      validate_command
      @repo = Lr::Repo.new(@cwd)
    end

    def execute
      output = send(@command)
      puts output if output
    end

    def fail_unless_repo
      fail 'Not a LR repository.'.colorize(:red) unless @repo.initialized?
    end

    def init
      repo.init
      nil
    end

    def log
      fail_unless_repo
      repo.log
    end

    def commit
      fail_unless_repo
      return 'usage: lr commit USERNAME MESSAGE'.colorize(:yellow) unless args.length == 2
      repo.commit(args[0], args[1])
    end

    def checkout
      fail_unless_repo
      return 'usage: lr checkout COMMIT'.colorize(:yellow) unless args.length == 1

      commit = commit_from_id(args[0])
      @repo.checkout(commit)
      "Checked out \"#{commit.message.colorize(:green)}\" by #{commit.username.colorize(:blue)}"
    end

    def commit_from_id(commit_id)
      if commit_id.length == 40
        commit_sha = commit_id
        @repo.object(commit_sha)
      elsif commit_id =~ /^HEAD(\^*)$/
        ups = Regexp.last_match(1).length
        commit = @repo.head
        ups.times do
          commit = @repo.object(commit.parent_sha)
          fail "unknown commit #{commit_id}".colorize(:red) unless commit
        end
        commit
      end
    end

    def show
      fail_unless_repo
      unless args.length == 1 && args[0].split(':').length == 2 # checkout && and
        return 'usage: lr show COMMIT:PATH'.colorize(:yellow)
      end
      commit_id, path = *args[0].split(':')
      commit = commit_from_id(commit_id)
      tree = @repo.object(commit.tree_sha)
      blob = @repo.blob_at_path(tree, path)
      blob ? blob.contents : "Can't find blob #{path}.".colorize(:red)
    end

    private

    def validate_command
      fail "Unknown command #{@command}.".colorize(:red) unless COMMANDS.include?(@command)
    end
  end
end
