def subtractor_model(a: int, b: int) -> int:
    """model of subtractor"""
    return (a - b) % (1 << 32)
