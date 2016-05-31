require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "A User has attributes" do
    
    let(:no_one){User.new(name: "Captain Planet", username: "IloveGaia247", venmo: "GaiaFan313", password: "we're the planeteers, you can be one too", email_confirmed: true)}

    it "has a name" do
      expect(no_one.name).to eq("Captain Planet")
    end
  end
end