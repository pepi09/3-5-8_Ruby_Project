require_relative     "deck"
require "test/unit"

class TestDeck < Test::Unit::TestCase
    def test_get_card
        assert_equal({"heart" => "Q"},Card.new("heart", "Q").getCard())
    end

    def test_print_card
        assert_equal("Q of heart",Card.new("heart", "Q").printCard())
    end
end