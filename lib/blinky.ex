defmodule Blinky do
  alias Nerves.Leds
  require Logger

  @led_list Application.get_env(:blinky, :led_list)

  def start() do
    led_list = @led_list

    Logger.debug("list of leds to blink is #{inspect(led_list)}")

    spawn(fn -> blink_leds_forever(led_list) end)
  end

  # call blink_led on each led in the list sequence, repeating forever
  defp blink_leds_forever(leds) do
    Enum.each(leds, &blink_led(&1))
    blink_leds_forever(leds)
  end

  def blink_led(led) do
    Leds.set([{led, true}])
    :timer.sleep(200)
    Leds.set([{led, false}])
    :timer.sleep(200)
  end
end
