require 'rails_helper'

RSpec.describe Result, type: :model do
  it "checks performance of the model" do
    input = 43
    res = Result.find_by(input: 43)
    res&.destroy
    result = [[1,1],[2,4],[3,9],[11,121],[22,484],[26,676]]
    local_res = Result.create input: input, output: ActiveSupport::JSON.encode(result)
    local_res.save
    res = Result.find_by(input: 43)
    db_result = ActiveSupport::JSON.decode(res.output)
    expect(db_result).to eq(result)
  end
  it "checks performance of the model" do
    input = 43
    res = Result.find_by(input: 43)
    res&.destroy
    result = [[1,1],[2,4],[3,9],[11,121],[22,484],[26,676]]
    result2 = [[1,1],[2,4],[3,9],[11,121]]
    local_res = Result.create input: input, output: ActiveSupport::JSON.encode(result)
    local_res.save

    expect {
    local_res = Result.create input: input, output: ActiveSupport::JSON.encode(result2)
    local_res.save
    }.to raise_error
  end
end
