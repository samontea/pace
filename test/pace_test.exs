defmodule PaceTest do
  use ExUnit.Case
  doctest Pace

  test "start link starts process" do
    {:ok, pid} = Pace.start_link
    assert Process.alive? pid
  end

  test "sending stop kills the process" do
    {:ok, pid} = Pace.start_link
    send pid, :stop
    Process.sleep(10)
    assert !(Process.alive? pid)
  end
end
