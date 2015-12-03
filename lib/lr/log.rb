class Lr
  class Log
    def initialize(repo)
      @repo = repo
      fail 'Log needs a Repo'.colorize(:red) unless repo.class <= Repo
    end

    def to_s
      if current = @repo.head
        log_lines = []
        while current
          log_lines << "#{current.to_sha} #{current.created_at.to_s.underline} #{current.username.colorize(:blue)} #{current.message.inspect.colorize(:green)}"
          current = @repo.read_object(current.parent_sha)
        end
        log_lines.join("\n")
      else
        'No commits.'.colorize(:green)
      end
    end
  end
end
