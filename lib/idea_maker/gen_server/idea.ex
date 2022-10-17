defmodule IdeaMaker.GenServer.Idea do
  use GenServer

  # Client
  alias IdeaMaker.{Db, Idea}
  # {:ok , pid} = IdeaMaker.GenServer.Idea.start_link([])
  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server (callbacks)

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:get_all, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  #   GenServer.cast(pid, {:insert_idea, %{title: "name", name: "asd",user_id: 32, group_id: 11 ,content: "Соси хуй"}})
  def handle_cast({:insert_idea, element}, state) do
    {:ok, idea} =
      Db.add(Idea, %{
        title: element.title,
        name: element.name,
        content: element.content,
        data: %{},
        user_id: element.user_id,
        group_id: element.group_id
      })

    {:noreply, [element | state]}
  end

  def terminate(reason, state) do
    {reason, state}
  end
end
