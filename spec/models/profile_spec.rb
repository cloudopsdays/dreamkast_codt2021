require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = Profile.new(
      sub: "stub",
      email: "tester@example.com",
      first_name: "Test",
      last_name: "Tester",
      industry_id: 2,
      occupation: "Solutions Architect",
      company_name: "CNDT",
      company_email: "cndt@example.com",
      company_address: "TOkyo",
      company_tel: "000-0000-0000",
      department: "aaaaaa",
      position: "bbbbbb",
    )
  end
  
  it "is valid with a all params" do
    expect(@profile).to be_valid
  end

  [:sub, :email, :first_name, :last_name, :industry_id, :occupation, :company_name, :company_email,
    :company_address, :company_tel, :department, :position].each do |param|
    it "is invalid without #{param}" do
      @profile[param] = nil
      expect(@profile).to be_invalid
    end
  end

  it "is invalid if email is not a valid format" do
    @profile[:email] = "foobar"
    expect(@profile).to be_invalid
  end

  it "is invalid if company_email is not a valid format" do
    @profile[:email] = "foobar"
    expect(@profile).to be_invalid
  end

  ["090-1234-5678", "09012345678", "+81-90-1234-5678", "+819012345678"].each do |tel|
    it "is valid if company_tel is a valid number" do
      @profile[:company_tel] = tel
      expect(@profile).to be_valid
    end
  end

  ["xxxxx", "09012345678X", "☀", "amsy0810"].each do |tel|
    it "is invalid if company_tel is a invalid number" do
      @profile[:company_tel] = tel
      expect(@profile).to be_invalid
    end
  end
end