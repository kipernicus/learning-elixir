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
    trunc(Float.floor((score-10)/2))
  end

  @spec roleD6 :: pos_integer()
  def roleD6 do
    Enum.random([1, 2, 3, 4, 5, 6])
  end

  @spec ability :: pos_integer()
  def ability do
    rolls = Enum.sort([roleD6(), roleD6(), roleD6(), roleD6()])
    highest = List.delete_at(rolls, 0)
    Enum.reduce(highest, 0, fn element, accumulator -> element + accumulator end)
  end

  @spec character :: t()
  def character do
    constitution = ability()
    hitpoints = 10+modifier(constitution)
    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: constitution,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: hitpoints
    }
  end
end
