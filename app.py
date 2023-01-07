content = ""

with open("/etc/nixos/users/alpha/theme/colors.nix", "r") as file:
    for line in file.readlines():
        if '#' in line and ';' in line:
            content += line.replace(" ", "").replace(";", "").replace("=", " ").replace('"', '')

colors = {}

for line in content.split("\n"):
    payload = line.split(" ")
    if len(payload) > 1:
        colors[payload[0]] = payload[1]

base16 = {
    'base00': 'bg',
    'base01': 'bg-lighter',
    'base02': 'black',
    'base03': 'light-black',
    'base04': 'dimblack',
    'base05': 'fg',
    'base06': 'white',
    'base07': 'bg',
    'base08': 'red',
    'base09': 'red',
    'base0A': 'yellow',
    'base0B': 'green',
    'base0C': 'red',
    'base0D': 'blue',
    'base0E': 'magenta',
    'base0F': 'blue'
}

for key, colorname in base16.items():
    base16[key] = colors[colorname]

# generate .nix file
generated_nix_file = """{}:

{
"""

for name, hex in base16.items():
    r = hex[1] + hex[2]
    g = hex[3] + hex[4]
    b = hex[5] + hex[6]

    generated_nix_file += '  {} = {{ hex.r = "{}"; hex.g = "{}"; hex.b = "{}"; }};\n'.format(
        name,
        r, g, b
    )

generated_nix_file += "}\n"

print(generated_nix_file)
