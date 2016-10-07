defmodule Pace do
  require Logger

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
