# Tests for the checker of problem 3c (both pages). quarto render runs them.
def test(check, symbols):
    x, e = symbols["x"], Symbol("e")
    def result(f):
        return check({"expressions": [f]}, symbols)
    for f in (2*x - e, 2*x - E, 2*(x - e) + e):
        assert result(f)["score"] == 1
    # Right line with a decimal value instead of e.
    assert result(2*x - Float("2.718281829"))["score"] == 0.5
    # Through the point with a wrong slope, right slope through another point, not a line.
    for f in (e + 0*x, 3*x/e - 3 + e, 2*x + e, x*log(x), 2*x - Float("2.7")):
        assert result(f)["score"] == 0
    assert result(3*x/e - 3 + e)["feedback"] == result(e + 0*x)["feedback"]
