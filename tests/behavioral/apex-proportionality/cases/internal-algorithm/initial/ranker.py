def choose(items, k):
    if k <= 0:
        return []
    return sorted(items, key=lambda row: (-row["score"], row["name"]))[:k]
