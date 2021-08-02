# frozen_string_literal: true

class QuotesController < Rulers::Controller
  def a_quote
    "May the fourth be with you"
  end

  def shakes
    render(:shakes, noun: :winking)
  end

  def card_trick
    n = params["card"] || "Queen"
    "Your card: the #{n} of spades!"
  end

  def fq
    @q = Rulers::FileModel.find(params["q"] || 1)
    render(:quote)
  end
end
