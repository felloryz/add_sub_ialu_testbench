def subtractor_model(a: int, b: int) -> int:
    """model of subtractor"""
    mask = 0xFFFFFFFF
    return (a - b) & mask
