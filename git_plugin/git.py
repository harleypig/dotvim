def validate_plugin_url(ctx, param, value):
    return f"{param}/{value}"

def validate_name(ctx, param, value):
    return f"{param}/{value}"

def validate_dir(ctx, param, value):
    return f"{param}/{value}"

def add_plugin(url):
    print(f"Adding plugin: {url}")

def move_plugin(name):
    print(f"Moving plugin: {name}")

def remove_plugin(name):
    print(f"Removing plugin: {name}")
