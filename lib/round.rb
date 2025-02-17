class Round

  attr_reader :deck, :turns, :turn_counter, :number_correct, :percent_correct,
              :turns_by_category, :feedback, :percent_correct_by_category

  def initialize(deck)
    @deck = deck
    @turns = []
    @turn_counter = 0
    @number_correct = 0
    @number_correct_by_category = Hash.new(0)
    @percent_correct = 0
    @turns_by_category = Hash.new(0)
    @percent_correct_by_category = Hash.new(0)
    @feedback = ""
  end

  def current_card
    @deck[turn_counter]
  end

  def take_turn(guess)
    new_turn = Turn.new(guess, current_card)
    card_cat = current_card.category
    @turns_by_category[card_cat] += 1
    @turns << new_turn
    if new_turn.correct?
      @number_correct += 1
      @number_correct_by_category[card_cat] += 1
    else
      @number_correct_by_category[card_cat] += 0
    end
    @feedback = new_turn.feedback
    pct_correct  = @number_correct.to_f / @turns.count.to_f * 100
    @percent_correct = "%0.0f%" % [pct_correct]
    pct_correct_cat = @number_correct_by_category[card_cat].to_f / @turns_by_category[card_cat].to_f * 100
    @percent_correct_by_category[card_cat] = "%0.0f%" % [pct_correct_cat]
    @turn_counter += 1
    new_turn
  end

  def number_correct_by_category(category)
    @number_correct_by_category[category]
  end

  def get_percent_correct_by_category(category)
    @percent_correct_by_category[category]
  end

end
