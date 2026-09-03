from veyra.sync_api import Veyra

ACCEPT_ENCODING = "identity"

with Veyra(headless=False) as browser:
    page = browser.new_page(extra_http_headers={"accept-encoding": ACCEPT_ENCODING})
    page.goto("https://abrahamjuliot.github.io/creepjs/")
    input("Press Enter to close...")
