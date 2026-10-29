# Tests for the checker of problem 1b (both pages). quarto render runs them.
def test(check, symbols):
    a, b = symbols["a"], symbols["b"]
    def score(f):
        return check({"expressions": [f]}, symbols)["score"]
    assert score(Integer(2)) == 1
    # Equal to the original, but not as simple as possible.
    assert score((a - 2)/(a/2 - 1)) == 0.5
    assert score(log(b**2)/log(b)) == 0.5
    assert score((a*log(b) - log(b**2))/((a - 2)*log(sqrt(b)))) == 0.5
    # Wrong answers from the real student set.
    for f in (Rational(5, 2)*log(b), -a/(a/2 - 1), (2*a - 4)/a, 2*log(a) + log(b), a*log(b), Integer(1)):
        assert score(f) == 0
