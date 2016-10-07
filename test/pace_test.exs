defmodule PaceTest do
  use ExUnit.Case
  doctest Pace

  import ExUnit.CaptureLog

  test "start link starts process" do
    {:ok, pid} = Pace.start_link
    assert Process.alive? pid
  end

  test "lap signal produces log contianing pid" do
    {:ok, pid} = Pace.start_link
    log = capture_log(fn ->
      send pid, {:lap, "hi"}
      Process.sleep(20)
    end)
    assert log =~ ~r/#{Kernel.inspect pid}/
  end

  test "lap signal produces log contianing time, milliseconds" do
    {:ok, pid} = Pace.start_link
    log = capture_log(fn ->
      send pid, {:lap, "hi"}
      Process.sleep(20)
    end)
      assert log =~ ~r/[\d|\.]* milliseconds/
  end

  test "lap signal produces log contianing message" do
    {:ok, pid} = Pace.start_link
    log = capture_log(fn ->
      send pid, {:lap, "hi"}
      Process.sleep(20)
    end)
      assert log =~ ~r/hi/
  end

  test "sending stop kills the process" do
    {:ok, pid} = Pace.start_link
    capture_log(fn ->
      send pid, :stop
      Process.sleep(20)
    end)
    assert !(Process.alive? pid)
  end

  test "sending stop produces a log containing pid" do
    {:ok, pid} = Pace.start_link
    log = capture_log(fn ->
      send pid, :stop
      Process.sleep(20)
    end)
    assert log =~ ~r/#{Kernel.inspect pid}/
  end

  test "sending stop produces a log containing time in milliseconds" do
    {:ok, pid} = Pace.start_link
    log = capture_log(fn ->
      send pid, :stop
      Process.sleep(20)
    end)
    assert log =~ ~r/[\d|\.]* milliseconds/
  end
end
