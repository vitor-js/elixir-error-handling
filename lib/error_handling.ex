defmodule ErrorHandling do
  def error_handling_1(num) do
    if num > 5 do
      raise MeuError
    end

    IO.puts("Segunda Informacao")
  end

  def error_handling_2(atom) do
    try do
      :casa = atom
    rescue
      e in MatchError -> false
    after
      IO.puts("Executando idependente de acerto ou erro")
    end
  end

  def error_handling_3(num) do
    try do
      if num == 5, do: throw(num)
      IO.inspect("O numero foi : #{num}")
    catch
      num -> "O valor errado foi #{num}"
    end
  end

  def error_handling_spawn do
    pid =
      spawn_link(fn ->
        IO.inspect("Entrou no processo")
        exit("Quebrou aqui")
        IO.inspect("Saindo normalmente , fim do processo.")
      end)

    pid
  end

  def soma({:ok, a}, b), do: {:ok, a + b}
  def sub({:ok, _a}, b), do: {:error, "Nao foi possivel subtrair"}
  def mult({:ok, a}, b), do: {:ok, a * b}
  def mult({:error, msg}, _b), do: {:error, msg}

  def error_handling_pattern_matching(a, b) do
    {:ok, a}
    |> soma(b)
    |> sub(b)
    |> mult(b)
  end
end

defmodule MeuError do
  defexception message: "Meu erro aconteceu"
end
