module Scrabble
  class Scoring

    LETTER_VALUES = {
      'a' => 1,
      'b' => 3,
      'c' => 3,
      'd' => 2,
      'e' => 1,
      'f' => 4,
      'g' => 2,
      'h' => 4,
      'i' => 1,
      'j' => 8,
      'k' => 5,
      'l' => 1,
      'm' => 3,
      'n' => 1,
      'o' => 1,
      'p' => 3,
      'q' => 10,
      'r' => 1,
      's' => 1,
      't' => 1,
      'u' => 1,
      'v' => 4,
      'w' => 4,
      'x' => 8,
      'y' => 4,
      'z' => 10
    }

    def self.score(word)
      return nil if word == nil || word.length > 7 || word.length == 0 || !word.upcase.match?(/^[A-Za-z]+$/)

      letters = word.split('')
      total = letters.reduce(0) do |sum, element|
        sum + LETTER_VALUES[element.downcase]
      end

      total += 50 if letters.length == 7

      return total
    end

    def self.tie_breaker(current_winner, word)
      if word.length == 7 && current_winner.length < 7
        return word
      elsif word.length < current_winner.length && current_winner.length < 7
        return word
      else
        return current_winner
      end
    end

    def self.pick_winner(array_of_words)
      seven_letter_word = array_of_words.find { |word| word.length == 7}
      if seven_letter_word
        return seven_letter_word
      else
        return array_of_words.min_by {|word| word.length }
      end
    end

    def self.get_score_hash(array_of_words)
      scores = {}
      array_of_words.each do |current_word|
        current_score = Scrabble::Scoring.score(current_word)
        if scores[current_score] == nil
          scores[current_score] = [current_word]
        else
          scores[current_score] << current_word
        end
      end
      return scores
    end

    def self.highest_score_from(array_of_words)
      if array_of_words.class != Array || array_of_words.empty?
        return nil
      end

      scores = get_score_hash(array_of_words)
      max_score = scores.keys.max

      return pick_winner(scores[max_score])
    end
  end










end
