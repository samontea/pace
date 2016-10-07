defmodule Pace do
  @moduledoc ~S"""
  Provides a process that can easily measure performance.

  ## Usage

  First start a pace process:
      iex> {:ok, pid} = Pace.start_link
      {:ok, #PID<0.185.0>}

  After the pace process is created it starts timing.
  Communication from now on with the process will be done by sending messages to the process.

  To restart the pace timer:
      iex> send pid, :restart
      :restart

  To log an elapsed time and message:
      iex> send pid, {:lap, "message"}
      :restart

  To stop the timer (logs the time elapsed):
      iex> send pid, :stop
      :restart
  """

  require Logger

  @doc """
  Starts a new Pace process.

  ## Examples

      iex> Pace.start_link
      {:ok, #PID<0.185.0>}
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
