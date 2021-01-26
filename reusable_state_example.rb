let(:valid_params) do
  {
    first_name: "John",
    last_name: "Doe",
    age: 30,
    city: "Toronto",
  }
end

context ".lives_here?" do
  it "is true" do
    expect(lives_here?(valid_params)).to eq(true)
  end

  it "is false for people outside of Toronto" do
    params = valid_params.merge(city: "Winnipeg")

    expect(lives_here?(params)).to eq(false)
  end
end
