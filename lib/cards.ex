defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
  Returns a list of strings representing a deck of playing cards.

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Randomizes the order of a given deck.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      iex> Cards.contains?(deck, "Ace of Cards")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 3)
      iex> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    bin = :erlang.term_to_binary(deck)
    File.write(filename, bin)
  end

  def load(file) do
    case File.read(file) do
      {:ok, bin} -> :erlang.binary_to_term(bin)
      {:error, :enoent} -> "error opening #{file}: file does not exist"
      {:error, reason} -> "an error occured: #{reason}"
    end
  end

  def create_hand(hand_size) do

    # These two are equivalent

    # Standard way.
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # Cards.deal(deck, hand_size)

    #Elixir way.
    # The |> operator receives what the previous function returns,
    # then sends it as the first argument for the next function.
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
