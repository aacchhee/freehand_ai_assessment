## Problem 1b: Simplifying

```{math-exercise}
#| label: v24-1b-svar
#| vars: a, b
#| field-labels: Simplified expression
#| mode: custom
#| givens: |
#|   expr = (a*log(b) - log(b**2))/((a - 2)*log(sqrt(b)))
#| similar-data: expr
#| harder: An expression that needs three logarithm rules (a power, a root and a product or quotient inside the logarithms) and still simplifies to a number or one short term.
#| simpler: A quotient that needs one rule, for example a power inside one logarithm.
#| checker: |
#|   T = {
#|       "right": "Correct, and as simple as possible.",
#|       "simplify": "Your expression is equal to the given one, but it can be simplified further. Use the logarithm rules and look for a common factor in the numerator and the denominator.",
#|       "wrong": "This is not equal to the given expression. Check the logarithm rules: ln(b^k) = k·ln b, ln √b = ½·ln b, and a·ln b is not ln(ab).",
#|   }
#|   def check(response, symbols):
#|       a, b = symbols["a"], symbols["b"]
#|       given, f = response["variables"]["expr"], response["expressions"][0]
#|       # Compare where the given expression is defined (b > 0 and real values).
#|       points = [(3, 5), (Rational(1, 2), 7), (5, Rational(3, 10)), (-Rational(3, 2), Rational(5, 2)),
#|                 (7, 11), (4, Rational(1, 3)), (Rational(9, 4), 2)]
#|       compared = 0
#|       try:
#|           if not f.free_symbols <= {a, b}:
#|               return {"score": 0, "feedback": T["wrong"]}
#|           for p, q in points:
#|               want = N(given.subs({a: p, b: q}))
#|               if not (want.is_real and want.is_finite):
#|                   continue
#|               compared += 1
#|               if abs(N(f.subs({a: p, b: q})) - want) > 1e-9 * max(1, abs(want)):
#|                   return {"score": 0, "feedback": T["wrong"]}
#|       except (TypeError, ValueError, ZeroDivisionError):
#|           return {"score": 0, "feedback": T["wrong"]}
#|       if compared < 3:
#|           return {"score": 0, "feedback": T["wrong"]}
#|       # As simple as SymPy gets it with the logarithm rules for a, b > 0, in the
#|       # expanded (ln a + 2 ln b) or the combined (ln(a b^2)) form.
#|       pa, pb = Dummy("a", positive=True), Dummy("b", positive=True)
#|       simplest = simplify(expand_log(given.subs({a: pa, b: pb}), force=True))
#|       limit = max(count_ops(expand_log(simplest, force=True)), count_ops(logcombine(simplest, force=True)))
#|       if count_ops(f) > limit:
#|           return {"score": 0.5, "feedback": T["simplify"]}
#|       return {"score": 1, "feedback": T["right"]}
#| tests:
#|   - name: as simple as possible
#|     answers: [raw("2")]
#|     expect: correct
#|   - name: equal but not simplified
#|     answers: [raw("(a-2)/(1/2*a-1)")]
#|     expect: partial
#|     score: 0.5
#|   - name: a power taken out of the wrong logarithm
#|     answers: [raw("5/2*ln(b)")]
#|     expect: wrong

Write as simply as possible:

$$\frac{a\cdot\ln b-\ln b^2}{(a-2)\cdot\ln\sqrt{b}}$$

Simplified expression: __[2]
```

::: {.ai-feedback #v24-1b profile="mathematics" image-upload="true" image-role="response" context="v24-1b-svar-question" reset-on-variant="v24-1b-fyll"}
**Show your working for 1b.** Upload a photo of what you wrote on paper.
:::

## Problem 3b: Derivative

```{math-exercise}
#| label: v24-3b-svar
#| vars: x
#| field-labels: Derivative
#| mode: custom
#| givens: |
#|   g = log(2*x**2 - 2*x**4)/2
#| similar-data: g
#| harder: The logarithm of a product or quotient, or a factor x in front of the logarithm, so the chain rule and the product or quotient rule are both needed; the derivative still simplifies to one fraction.
#| simpler: The logarithm of a linear or simple quadratic inner function, without a constant factor.
#| checker: |
#|   T = {
#|       "right": "Correct, and simplified.",
#|       "one_fraction": "Your derivative is right, but write it as one fraction.",
#|       "common_factor": "Your derivative is right, but the numerator and the denominator still have a common factor. Simplify further.",
#|       "inner": "Check the chain rule: the derivative of ln u is u′/u. Did you multiply by the derivative of the inner function u?",
#|       "factor": "Almost: check what happens to the constant factor in front of the logarithm.",
#|       "outer": "You have the derivative of the inner function, but the derivative of ln u is u′/u. What must you divide by?",
#|       "wrong": "This is not the derivative. Check the rules you need: the chain rule (the derivative of ln u is u′/u), the product rule, and constant factors.",
#|   }
#|   def check(response, symbols):
#|       from sympy import degree, gcd
#|       x = symbols["x"]
#|       g, f = response["variables"]["g"], response["expressions"][0]
#|       target = diff(g, x)
#|       def equal(h, k):
#|           # Compare at points where k is defined and real (at least three).
#|           compared = 0
#|           try:
#|               for p in (Rational(1, 3), -Rational(1, 2), Rational(7, 10), -Rational(9, 10), Rational(1, 5),
#|                         2, 3, -2, Rational(5, 2), 7):
#|                   want = N(k.subs(x, p))
#|                   if not (want.is_real and want.is_finite):
#|                       continue
#|                   compared += 1
#|                   if abs(N(h.subs(x, p)) - want) > 1e-9 * max(1, abs(want)):
#|                       return False
#|           except (TypeError, ValueError, ZeroDivisionError):
#|               return False
#|           return compared >= 3
#|       if not f.free_symbols <= {x}:
#|           return {"score": 0, "feedback": T["wrong"]}
#|       if equal(f, target):
#|           simplest = cancel(target)
#|           if simplest.is_rational_function(x):
#|               if f.is_Add and not simplest.is_polynomial(x):
#|                   return {"score": 0.5, "feedback": T["one_fraction"]}
#|               numerator, denominator = f.as_numer_denom()
#|               try:
#|                   common = degree(gcd(expand(numerator), expand(denominator)), x) > 0
#|               except Exception:
#|                   common = False
#|               if common:
#|                   return {"score": 0.5, "feedback": T["common_factor"]}
#|           return {"score": 1, "feedback": T["right"]}
#|       # Typical slips with g = c*ln(u): the inner derivative or the factor c.
#|       c, rest = g.as_coeff_Mul()
#|       if rest.func == log:
#|           u = rest.args[0]
#|           slips = [(c/u, "inner"), (1/u, "inner"), (c*diff(u, x), "outer"), (diff(u, x), "outer")]
#|           if c != 1:
#|               slips.append((target/c, "factor"))
#|           for h, key in slips:
#|               if equal(f, h):
#|                   return {"score": 0, "feedback": T[key]}
#|       return {"score": 0, "feedback": T["wrong"]}
#| tests:
#|   - name: simplified fraction
#|     answers: [raw("(1-2x^2)/(x(1+x)(1-x))")]
#|     expect: correct
#|   - name: common factor left
#|     answers: [raw("(2x-4x^3)/(2x^2-2x^4)")]
#|     expect: partial
#|     score: 0.5
#|   - name: inner derivative missing
#|     answers: [raw("1/(4x^2-4x^4)")]
#|     expect: wrong

Differentiate the function and simplify the answer as far as possible.

$$g(x)=\frac{1}{2}\ln\left(2x^2-2x^4\right)$$

$g'(x)=$ __[(1-2*x^2)/(x-x^3)]
```

::: {.ai-feedback #v24-3b profile="mathematics" image-upload="true" image-role="response" context="v24-3b-svar-question" reset-on-variant="v24-3b-fyll"}
**Show your working for 3b.** Upload a photo of what you wrote on paper.
:::

## Problem 3c: Tangent

```{math-exercise}
#| label: v24-3c-svar
#| vars: x, e
#| field-labels: Tangent
#| mode: custom
#| givens: |
#|   h = x*log(x)
#|   x0 = E
#| similar-data: h, x0
#| harder: A function such as x²·ln x or ln(x²+1) at a point where the value and the slope are exact but not whole numbers.
#| simpler: h(x) = ln x or a power of x, at a point such as x = 1 or x = e.
#| checker: |
#|   T = {
#|       "right": "Correct: the line has the right slope and passes through the point of tangency.",
#|       "exact": "The line is right, but the problem asks for exact values. Write e, ln 2 and so on instead of decimal numbers.",
#|       "slope": "The line passes through the point of tangency, but the slope is wrong. The slope is the derivative at that point: check the derivative (product rule, chain rule).",
#|       "point": "The slope is right, but the line does not pass through the point of tangency. Check the function value at the point and the one-point formula.",
#|       "line": "A tangent is a straight line. Write it in the form y = ax + b.",
#|       "symbols": "Use only x and numbers such as e in the answer: write the right-hand side of y = ….",
#|       "wrong": "This is not the tangent. Find the slope (the derivative at the point) and the point (x₀, h(x₀)), and use the one-point formula y − y₁ = a(x − x₁).",
#|   }
#|   def check(response, symbols):
#|       x = symbols["x"]
#|       h, x0 = response["variables"]["h"], response["variables"]["x0"]
#|       f = response["expressions"][0].subs(symbols["e"], E)
#|       if not f.free_symbols <= {x}:
#|           return {"score": 0, "feedback": T["symbols"]}
#|       try:
#|           if diff(f, x, 2) != 0:
#|               return {"score": 0, "feedback": T["line"]}
#|           slope, point = N(diff(h, x).subs(x, x0)), N(h.subs(x, x0))
#|           slope_ok = abs(N(diff(f, x)) - slope) < 1e-6 * max(1, abs(slope))
#|           through_ok = abs(N(f.subs(x, x0)) - point) < 1e-6 * max(1, abs(point))
#|       except (TypeError, ValueError):
#|           return {"score": 0, "feedback": T["wrong"]}
#|       if slope_ok and through_ok:
#|           if f.has(Float):
#|               return {"score": 0.5, "feedback": T["exact"]}
#|           return {"score": 1, "feedback": T["right"]}
#|       if through_ok:
#|           return {"score": 0, "feedback": T["slope"]}
#|       if slope_ok:
#|           return {"score": 0, "feedback": T["point"]}
#|       return {"score": 0, "feedback": T["wrong"]}
#| tests:
#|   - name: exact tangent
#|     answers: [raw("2x-e")]
#|     expect: correct
#|   - name: decimal instead of e
#|     answers: [raw("2x-2.718281829")]
#|     expect: partial
#|     score: 0.5
#|   - name: sign error in the product rule
#|     answers: [raw("e")]
#|     expect: wrong

Find the equation of the tangent to the function

$$h(x)=x\ln x$$

through the point $\left(e,h(e)\right)$. Give the answer with exact values.

$y=$ __[2*x-E]
```

::: {.ai-feedback #v24-3c profile="mathematics" image-upload="true" image-role="response" context="v24-3c-svar-question" reset-on-variant="v24-3c-fyll"}
**Show your working for 3c.** Upload a photo of what you wrote on paper.
:::
