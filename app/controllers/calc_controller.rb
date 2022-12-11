# frozen_string_literal: true

# class for calculating input and writing it to database
class CalcController < ApplicationController
  def input; end

  def view
    @input = params[:less_than_number].to_i
    res = Result.find_by(input: @input)
    if res
      @result = ActiveSupport::JSON.decode(res.output)
    else
      @result = calculate(@input)
      add_to_db(@input, @result)
    end
  end

  def xml
    results = Result.all.map do |result|
      { input: result.input, output: result.output }
    end
    render xml: results
  end

  private

  def calculate(nmax)
    [*1..nmax].select { |num| (num**2).to_s.reverse == (num**2).to_s && num <= nmax }
              .map { |elem| [elem, elem**2] }
  end

  def add_to_db(input, result)
    local_res = Result.create input: input, output: ActiveSupport::JSON.encode(result)
    local_res.save
  end
end
