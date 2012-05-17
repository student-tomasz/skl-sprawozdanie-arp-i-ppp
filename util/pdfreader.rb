class PDFReaderCommand
  class << self
    def find
      case RbConfig::CONFIG['host_os']
      when /mac|darwin/
        MacPDFReaderCommand.get_command
      when /linux|bsd/
        LinuxPDFReaderCommand.get_command
      else
        raise "MS BOB NOT SUPPORTED!"
      end
    end
  end

  def initialize(command)
    @command = command
  end

  def run(document)
    system "#{@command} #{document} > /dev/null"
  end

end

class LinuxPDFReaderCommand < PDFReaderCommand
  @@readers = %w{xdg-open evince okular gpdf xpdf}

  class << self
    def get_command
      readers = @@readers.map{|r| LinuxPDFReaderCommand.new(r)}
      readers.drop_while(&:not_available?).first
    end
  end

  def not_available?
    `which #{@command}`.empty?
  end
end

class MacPDFReaderCommand < PDFReaderCommand
  class << self
    def get_command
      MacPDFReaderCommand.new("open")
    end
  end
end
