defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div(score - 10, 2)
  end

  @spec rollD6 :: pos_integer()
  def rollD6 do
    Enum.random(1..6)
  end

  @spec ability :: pos_integer()
  def ability do
    Enum.sum(List.delete_at(Enum.sort([rollD6(), rollD6(), rollD6(), rollD6()]), 0))
  end

  @spec character :: t()
  def character do
    constitution = ability()
    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: constitution,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: 10 + modifier(constitution)
    }
  end
end
