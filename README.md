# Pace

[![Build Status](https://travis-ci.org/samontea/pace.svg?branch=master)](https://travis-ci.org/samontea/pace)

This library implements a light weight process that can be used to easily analyse the performance of your applicaiton.

## Usage

If [available in Hex](https://hex.pm/packages/pace), the package can be installed as:

  1. Add `pace` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:pace, "~> 0.1.0"}]
    end
    ```

  2. Start a pace process sometime in your application:

    ```elixir
	{:ok, pid} = Pace.start_link
    ```

  3. The following api is exposed:

    ```elixir
	send pid, :restart # restarts the server's timer
	send pid, {:lap, "message"} # logs a lap message containing the pid of the pace process, current time ellapsed, and message
	send pid, :stop  # logs a termination message containing the pid of the pace process and current time ellapsed. the timer process is stopped
    ```
