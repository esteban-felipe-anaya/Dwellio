"""Generates Dwellio's launcher icon: a white house with a keyhole on the
brand teal (#00696D). Produces:
  - dwellio_icon.png        full-bleed icon (iOS / web / desktop / legacy Android)
  - dwellio_foreground.png  transparent house in the adaptive safe-zone (Android)
Run:  python make_icon.py
"""
from PIL import Image, ImageDraw

SIZE = 1024
TEAL = (0, 105, 109, 255)          # #00696D
TEAL_DARK = (0, 80, 84, 255)
WHITE = (255, 255, 255, 255)


def house_mask(size, scale=1.0):
    """An L-mode mask: white = house, black = transparent (incl. keyhole)."""
    mask = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(mask)
    c = size / 2
    s = scale

    def sx(x):  # scale a coordinate about the center
        return c + (x - c) * s

    # Roof (triangle)
    d.polygon(
        [(sx(512), sx(225)), (sx(238), sx(508)), (sx(786), sx(508))],
        fill=255,
    )
    # Body (rounded rectangle)
    d.rounded_rectangle(
        [sx(322), sx(486), sx(702), sx(792)],
        radius=int(46 * s),
        fill=255,
    )
    # Keyhole — circle + tapered stem, cut back to transparent
    d.ellipse([sx(454), sx(556), sx(570), sx(672)], fill=0)
    d.polygon(
        [(sx(486), sx(640)), (sx(538), sx(640)), (sx(556), sx(742)), (sx(468), sx(742))],
        fill=0,
    )
    return mask


def main():
    # Background with a soft vertical gradient for a little depth.
    bg = Image.new("RGBA", (SIZE, SIZE), TEAL)
    grad = Image.new("RGBA", (SIZE, SIZE), TEAL)
    gd = ImageDraw.Draw(grad)
    for y in range(SIZE):
        t = y / SIZE
        r = int(TEAL[0] + (TEAL_DARK[0] - TEAL[0]) * t)
        g = int(TEAL[1] + (TEAL_DARK[1] - TEAL[1]) * t)
        b = int(TEAL[2] + (TEAL_DARK[2] - TEAL[2]) * t)
        gd.line([(0, y), (SIZE, y)], fill=(r, g, b, 255))
    bg = grad

    white = Image.new("RGBA", (SIZE, SIZE), WHITE)

    # Full icon: house fills most of the canvas.
    full = bg.copy()
    full.paste(white, (0, 0), house_mask(SIZE, scale=1.0))
    full.save("dwellio_icon.png")

    # Adaptive foreground: transparent, house shrunk into the safe zone (~66%).
    fg = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    fg.paste(white, (0, 0), house_mask(SIZE, scale=0.66))
    fg.save("dwellio_foreground.png")

    print("Wrote dwellio_icon.png and dwellio_foreground.png")


if __name__ == "__main__":
    main()
