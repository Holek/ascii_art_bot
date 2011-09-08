require "./spec/spec_helper"

describe AsciiArtBot do
  let(:input) { "dance around the world" }
  let(:output) { '      _                                                        _   _   _                               _     _ 
     | |                                                      | | | | | |                             | |   | |
   __| | __ _ _ __   ___ ___    __ _ _ __ ___  _   _ _ __   __| | | |_| |__   ___  __      _____  _ __| | __| |
  / _` |/ _` | \'_ \ / __/ _ \  / _` | \'__/ _ \| | | | \'_ \ / _` | | __| \'_ \ / _ \ \ \ /\ / / _ \| \'__| |/ _` |
 | (_| | (_| | | | | (__  __/ | (_| | | | (_) | |_| | | | | (_| | | |_| | | |  __/  \ V  V / (_) | |  | | (_| |
  \__,_|\__,_|_| |_|\___\___|  \__,_|_|  \___/ \__,_|_| |_|\__,_|  \__|_| |_|\___|   \_/\_/ \___/|_|  |_|\__,_|
                                                                                                               
                                                                                                               '}
  subject { AsciiArtBot.new(AwesomeBotFactory::ExamplePayload.new("match" => ["/ascii #{input}", "", input])) }
  
  its(:text) { should eql(input) }
  its(:reply) { should eql({ :type => "PasteMessage", :body => output })}
  
  describe "as a rack application" do
    let(:app) { AsciiArtBot }
    before do
      post "/ascii_art_bot", {}, :input => AwesomeBotFactory::ExamplePayload.new("match" => ["/ascii #{input}", "", input]).as_json
    end
    let(:json_body) { JSON.parse(last_response.body) }

    it { last_response.should be_ok }
    it { json_body["type"].should eql("PasteMessage") }
    it { json_body["body"].should eql(output) }
  end
end
