  
RSpec.describe User, type: :model do
  
  context "a User has attributes" do
    
    let(:no_one) {User.new(name: "Captain Planet", username: "IloveGaia247", venmo: "GaiaFan313", password: "we're the planeteers, you can be one too", email_confirmed: true)}
    let(:no_email) {User.new(name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313", password: "we're the pleenarteers, you can be one three!", email_confirmed: false)}

    it "has attributes" do
      expect(no_one.name).to eq("Captain Planet")
      expect(no_one.username).to eq("IloveGaia247")
      expect(no_one.venmo).to eq("GaiaFan313")
      expect(no_one.password).to eq("we're the planeteers, you can be one too")
      expect(no_one.email_confirmed).to be_truthy
    end

    it "generates a password digest" do
      no_one.save
      expect(no_one.password_digest).to be_a_kind_of(String)
      expect(no_one.password_digest).to_not eq(no_one.password)
    end

    it "is created with a false Email email_confirmed flag" do
      new_user = User.new
      expect(new_user.email_confirmed).to be_falsy
    end
  end

  context "a User can confirm their email" do
    
    let(:no_one) {User.new(name: "Captain Planet", username: "IloveGaia247", venmo: "GaiaFan313", password: "we're the planeteers, you can be one too", email_confirmed: true)}
    let(:no_email) {User.new(name: "Captain Ploonet", username: "IloveGaeo247", venmo: "GuoaFin313", password: "we're the pleenarteers, you can be one three!", email_confirmed: false)}
    let(:legit_email) {EmailAddress.new(email_address: "bestemail@fake-o.com", confirmed: false, confirm_token: "This should be blank!") }

    it "can confirm its email address" do
      no_email.email_addresses << legit_email
      # allow(Shirt).to receive(:find).with("3").and_return(shirt)
      allow(Organization).to receive(:find_or_create_by).and_return(Organization.new(domain_name: legit_email.email_address.split('@')[1]))
      no_email.email_activate
      expect(no_one.email_confirmed).to be_truthy
      expect(legit_email.confirmed).to be_truthy
      expect(no_one.confirm_token).to be_nil
    end
  end
end