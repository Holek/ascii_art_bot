class AsciiArtBot < AwesomeBotFactory::Skill
  require 'artii'
  require 'artii/figlet'

  configure do |c|
    c.name = "AsciiArtBot"
    c.description = ""
    c.author = "holek"
    c.url = "http://abf-ascii-art-bot.herokuapp.com/ascii_art_bot"
    c.regex = "\/ascii (.+)"
    c.help = ""
  end
  
  matches :text
  
  def reply
    a = ::Artii::Base.new self.text

    { :type => "PasteMessage", :body => a.output }
  end
  
end