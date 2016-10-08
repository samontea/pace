defmodule Pace do
  @moduledoc ~S"""
  Provides a process that can easily measure performance.

  ## Usage

  First start a pace process:

      {:ok, pid} = Pace.start_link

  After the pace process is created it starts timing.
  Communication from now on with the process will be done by sending messages to the process.

  To restart the pace timer:

      iex> {:ok, pid} = Pace.start_link
      iex> send pid, :restart
      :restart

  To log an elapsed time and message:

      iex> {:ok, pid} = Pace.start_link
      iex> send pid, {:lap, "message"}
      {:lap, "message"}

  To stop the timer (logs the time elapsed):

      iex> {:ok, pid} = Pace.start_link
      iex> send pid, :restart
      :restart
  """

  require Logger

  @doc """
  Starts a new Pace process.

  ## Examples

      Pace.start_link
  """
  def start_link() do
    {:ok, spawn_link(fn -> listen(System.monotonic_time(:nanoseconds)) end)}
  end

  defp listen(start_time) do
    receive do
      :restart ->
        listen(System.monotonic_time(:nanoseconds))
      {:lap, message} ->
        Logger.debug "#{Kernel.inspect self} #{(System.monotonic_time(:nanoseconds) - start_time) / 1000000} milliseconds:\n#{message} "
        listen(start_time)
      :stop ->
        Logger.debug "#{Kernel.inspect self} stopped:\n#{(System.monotonic_time(:nanoseconds) - start_time) / 1000000} milliseconds"
    end
  end
end
