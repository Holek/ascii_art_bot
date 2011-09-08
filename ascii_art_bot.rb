class AsciiArtBot < AwesomeBotFactory::Skill
  require 'artii'
  require 'artii/figlet'

  configure do |c|
    c.name = "AsciiArtBot"
    c.description = ""
    c.author = "holek"
    c.url = "http://abf-ascii-art-bot.herokuapp.com/ascii_art_bot"
    c.regex = "\/ascii(\:?[a-zA-Z-\.]*?)(\s.*)"
    c.help = ""
  end

  matches :command, :text

  def reply
    self.command.slice!(0) if self.command
    case self.command
    when "help":
      out = "Hello, I'm the ASCII bot! I can make your awesome messages even more awesome!
Available commands:
/ascii [your text]
/ascii:[font-name] [your text]
/ascii:font-list
/ascii:help"
    when "font-list"
      out = ::Artii::Base.new("--list").output
    else
      if self.command
        a = ::Artii::Base.new("--font",self.command,self.text)
      else
        a = ::Artii::Base.new(self.text)
      end
      out = a.output
    end
    { :type => "PasteMessage", :body => out }
  end

end