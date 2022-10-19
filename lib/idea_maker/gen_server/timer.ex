defmodule Idemaker.GenServer.Timer do
  use GenServer

  def start_link(init_args) when is_integer(init_args) do
    {:ok, pid} = GenServer.start_link(init_args)
  end

  def init(args) do
    {:ok, args}
  end

  def handle_call(:time, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, element, element}
  end

  def handle_cast({:tick, element}, state) do
    {:noreply, element, element}
  end

  def timer(pid, seconds) when seconds > -1 do
    :timer.sleep(1000)
    IO.inspect(seconds)

    timer(pid, seconds - 1)
  end
end
