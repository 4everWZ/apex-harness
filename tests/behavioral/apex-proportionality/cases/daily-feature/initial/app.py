def handle(method, path, ready):
    if method == "GET" and path == "/health/live":
        return 200, {"alive": True}
    return 404, {"error": "not found"}
