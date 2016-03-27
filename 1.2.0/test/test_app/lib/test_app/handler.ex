defmodule TestApp.Handler do
  def init({:tcp, :http}, req, opts) do
    headers = [{"content-type", "text/html"}]

    time = Timex.DateTime.now |> Timex.format!("%d/%m/%Y %I/%M/%S%p", :strftime)

    body = "<html><head><title>HTTPTimeServer powered by Elixir</title>" <>
      "<meta http-equiv=\"refresh\" content=\"1\"></head>" <>
      "<body><p style=\"text-align: center; font-size: 48px;\">" <>
      time <>
      "</p></body></html>"

    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, opts}
  end

  def handle(req, state) do
    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
