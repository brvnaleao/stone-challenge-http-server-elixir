defmodule StoneChallenge.BusinessLogic do

  def init(items, email) do
    items
    |> clean_values
    |> get_totals(String.split(email, "_"))
    |> Jason.encode!

  end

  defp clean_values(items) do
    items
    |> String.split("_")
    |> Enum.chunk_every(3)
    |> Enum.reduce(0, fn [_item, amount, quantity], acc ->
      amount_number = String.to_integer amount
      quantity_number = String.to_integer quantity

      if amount_number <= 0 or quantity_number <= 0 do
        throw "Cannot receive quantity or value inferior to 0!"
      end
      amount_number * quantity_number + acc
    end)
end

  defp get_totals(amount, emails) do
    emails_total = length emails

    if emails_total <= 0 do
      throw "The programm must receive at leat one E-mail!"
    end
    base_part = div amount, emails_total
    remainder = rem amount, emails_total

    divide_values_per_person(remainder, base_part, emails)
  end

  def divide_values_per_person(remainder, base_part, emails) do

    Enum.reduce(emails, %{}, fn email, map ->
      Map.put(map, email, base_part)
    end)
    |> sum_remainder(remainder)


  end

  defp sum_remainder(mapped_values, 0), do: mapped_values

  defp sum_remainder(mapped_values, rem) do

    accumulator = %{new_map: %{}, remainder: rem}
    final_value=
    Enum.reduce(mapped_values, accumulator, &reducing_values/2)

    final_value.new_map
  end

  defp reducing_values({email, value}, %{new_map: map_values, remainder: 0}) do
    incremented_map = Map.put(map_values, email, value)
    %{new_map: incremented_map, remainder: 0}
  end

  defp reducing_values({email, value}, %{new_map: map_values, remainder: rest}) do
    incremented_map = Map.put(map_values, email, value + 1)
    %{new_map: incremented_map, remainder: rest - 1}
  end

end
