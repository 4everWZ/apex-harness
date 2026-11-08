def parse_limit(value=None):
    if value is None:
        return 30
    value = int(value)
    if not 5 <= value <= 120:
        raise ValueError("limit must be from 5 to 120")
    return value
