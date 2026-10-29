# Tests for the checker of problem 3b (both pages). quarto render runs them.
def test(check, symbols):
    x = symbols["x"]
    def result(f):
        return check({"expressions": [f]}, symbols)
    for f in ((1 - 2*x**2)/(x - x**3), (1 - 2*x**2)/(x*(1 + x)*(1 - x)), -(2*x**2 - 1)/(x - x**3)):
        assert result(f)["score"] == 1
    # Right derivative, not simplified.
    assert result(1/x - x/(1 - x**2))["score"] == 0.5
    assert result((2*x - 4*x**3)/(2*x**2 - 2*x**4))["score"] == 0.5
    # Wrong: inner derivative missing, factor 1/2 lost, only the inner derivative.
    texts = {result(f)["feedback"] for f in (1/(2*(2*x**2 - 2*x**4)), 1/(4*x**2 - 4*x**4))}
    assert len(texts) == 1
    for f in (1/(4*x**2 - 4*x**4), (4*x - 8*x**3)/(2*x**2 - 2*x**4), 2*x - 4*x**3, 2 - 4*x**2):
        assert result(f)["score"] == 0
