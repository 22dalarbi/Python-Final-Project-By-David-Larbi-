load("render.star", "render")
load("encoding/base64.star", "base64")
load("encoding/json.star", "json")
load("http.star", "http")
load("time.star", "time")



SEPTA_ICON = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAABAAAAAMCAIAAADkharWAAAAAXNSR0IArs4c6QAAAZ5JREFUKJFj
/Pv33+ELz+48/cTAwCDAwxbsqMyABH4d2/P/5VMoh4uHzdGH5fCFZ/FN+xkYGNhZmeZ
UOyCr/vv88Y+eSoZvX+Aifw5sZYKYzcDAEO+tbmsghTD76O6viW7IqhkYGP5ev8gC52Q
EacPZX4pj/l09y4ANQDXoKQvxcLIyMDD8////57ZV7PF5rHpmDAwMf188+ZoZwPD9K1wDE4S6dPfdhoP3GRgYGBkZ2b3C/pw98vvkfgYGBmYJGa
6eJYyCIugaGBgYpq258u7TD4gezsSiP1fP/T6x7////yzKGpz1UxmFxdE1PHjxJall/+v3319/+P76w/cvQVmvrt/+++cfAwMDi4YeV9N0
BnZOhB8g4MKtt6aJayHs////K0lL7EuAmvjv3RuGH98YOLlRNCCDijjDFH9NRkZGBgaGX0d2/egsZWBkZGBgYGFhYkQPOGbGjd2eWoqCUNUn9
v/oqWT4/YuBgYGBkYHJxVRGVpzn3/////7//8/wP8ZD9eryCG0lIYjqP7cuf28tYPj+heH/v/9sbByFLQDZHaCyl5AouQAAAABJRU5ErkJggg==
""")

SEPTA_URL = """[
  {
    "orig_train": "3541",
    "orig_line": "West Trenton",
    "orig_departure_time": "5:02PM",
    "orig_arrival_time": "5:40PM",
    "orig_delay": "2 min",
    "isdirect": "true"
  }
]"""

def clock(config):
    timezone = config.get("timezone") or "America/New_York"
    now = time.now().in_location(timezone)
    '''return render.Root(
        delay = 500,
        child = render.Box(
            child = render.Animation(
                children = [
                    render.Text(
                        content = now.format("3:04 PM"),
                        font = "6x13",
                    ),
                    render.Text(
                        content = now.format("3 04 PM"),
                        font = "6x13",
                    ),
                ],
            ),
        ),
    )'''



def main(config):
    timezone = config.get("timezone") or "America/New_York"
    now = time.now().in_location(timezone)
    ting =  json.decode(SEPTA_URL)
    station = ting[0]["orig_line"]
    lateness = ting[0][ "orig_delay"]
    depart = ting[0]["orig_departure_time"]
    print(station)
    return render.Root(
        delay = 500,
        child = render.Stack(
            children=[
                    render.Column(
                        children=[
                            render.Text(station),
                            render.Text(depart),
                            render.Text("", height = 9),
                            render.Text(lateness),
                            ],
                    ),
                    render.Row(
                        cross_align = "center",
                        expanded = True,
                        main_align = "end",
                        children=[
                            #render.Text("bruh")
                            render.Image(src=SEPTA_ICON, width = 8, height = 6),
                            ],
                    ),
                    render.Box(
                        child = render.Animation(
                            children = [
                                render.Text(
                                    content = ("       " + now.format("3 04 PM")),
                                    font = "tom-thumb",
                                    #offset = -5,
                                    #height = 6,
                                ),
                                render.Text(
                                    content = ("       " + now.format("3 04 PM")),
                                    font = "tom-thumb",
                                    #offset = -5,
                                    #height = 6,
                                ),
                            ],
                        ),
                    ),
                ],
                )
        )  










# -pixlet serve --watch examples/septatrials.star
