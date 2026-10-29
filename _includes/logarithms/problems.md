## Problem 1b: Simplifying

::: {#v24-oppg1b .ai-context}
Write as simply as possible:

$$\frac{a\cdot\ln b-\ln b^2}{(a-2)\cdot\ln\sqrt{b}}$$
:::

```{math-exercise}
#| label: v24-1b-svar
#| caption: 1b · Final answer
#| vars: a, b
#| field-labels: The simplified expression
#| mode: custom
#| context: none
#| checker: |
#|   T = {
#|       "right": "Correct, and as simple as possible.",
#|       "simplify": "Your expression is equal to the original one, but it can be simplified further. Look for a common factor in the numerator and the denominator.",
#|       "wrong": "This is not equal to the original expression. Check the logarithm rules: both ln b² and ln √b can be written with ln b, and a·ln b is not ln(ab).",
#|   }
#|   def check(response, symbols):
#|       a, b = symbols["a"], symbols["b"]
#|       f = response["expressions"][0]
#|       points = [(3, 5), (Rational(1, 2), 7), (5, Rational(3, 10)), (-Rational(3, 2), Rational(5, 2)), (7, 11)]
#|       try:
#|           equal = f.free_symbols <= {a, b} and all(
#|               abs(N(f.subs({a: p, b: q}) - 2)) < 1e-9 for p, q in points)
#|       except (TypeError, ValueError, ZeroDivisionError):
#|           equal = False
#|       if not equal:
#|           return {"score": 0, "feedback": T["wrong"]}
#|       if f.free_symbols:
#|           return {"score": 0.5, "feedback": T["simplify"]}
#|       return {"score": 1, "feedback": T["right"]}
#| tests: _includes/logaritmer/tests/1b.py

Simplified expression: __[]
```

::: {.ai-feedback #v24-1b profile="mathematics" image-upload="true" image-role="response" context="v24-oppg1b" reset-on-variant="v24-1b-fyll"}
**Show your working for 1b.** Upload a photo of what you wrote on paper.
:::

## Problem 3b: Derivative

::: {#v24-oppg3b .ai-context}
Differentiate the function and simplify the answer as far as possible.

$$g(x)=\frac{1}{2}\ln\left(2x^2-2x^4\right)$$
:::

```{math-exercise}
#| label: v24-3b-svar
#| caption: 3b · Final answer
#| vars: x
#| field-labels: g′(x)
#| mode: custom
#| context: none
#| checker: |
#|   T = {
#|       "right": "Correct, and written as one simplified fraction.",
#|       "one_fraction": "Your derivative is right, but write it as one fraction.",
#|       "common_factor": "Your derivative is right, but the numerator and the denominator still have a common factor. Simplify further.",
#|       "inner": "Check the chain rule: the derivative of ln u is u′/u. Did you multiply by the derivative of the inner function u?",
#|       "half": "Almost: check what happens to the factor ½ in front of the logarithm.",
#|       "outer": "You have the derivative of the inner function, but the derivative of ln u is u′/u. What must you divide by?",
#|       "wrong": "This is not g′(x). Use the chain rule (the derivative of ln u is u′/u) and keep the factor ½.",
#|   }
#|   def check(response, symbols):
#|       from sympy import degree, gcd
#|       x = symbols["x"]
#|       f = response["expressions"][0]
#|       points = [Rational(1, 3), -Rational(1, 2), Rational(7, 10), -Rational(9, 10), Rational(1, 5)]
#|       def same(g):
#|           try:
#|               return f.free_symbols <= {x} and all(abs(N((f - g).subs(x, p))) < 1e-9 for p in points)
#|           except (TypeError, ValueError, ZeroDivisionError):
#|               return False
#|       u = 2*x**2 - 2*x**4
#|       target = (1 - 2*x**2)/(x - x**3)
#|       if same(target):
#|           if f.is_Add:
#|               return {"score": 0.5, "feedback": T["one_fraction"]}
#|           numerator, denominator = f.as_numer_denom()
#|           if degree(gcd(expand(numerator), expand(denominator)), x) > 0:
#|               return {"score": 0.5, "feedback": T["common_factor"]}
#|           return {"score": 1, "feedback": T["right"]}
#|       if any(same(g) for g in (1/(2*u), 1/u, 1/(4*x**2 - 4*x**4), Rational(1, 2)*log(u))):
#|           return {"score": 0, "feedback": T["inner"]}
#|       if same(2*target):
#|           return {"score": 0, "feedback": T["half"]}
#|       if same(diff(u, x)/2) or same(diff(u, x)):
#|           return {"score": 0, "feedback": T["outer"]}
#|       return {"score": 0, "feedback": T["wrong"]}
#| tests: _includes/logaritmer/tests/3b.py

$g'(x)=$ __[]
```

::: {.ai-feedback #v24-3b profile="mathematics" image-upload="true" image-role="response" context="v24-oppg3b" reset-on-variant="v24-3b-fyll"}
**Show your working for 3b.** Upload a photo of what you wrote on paper.
:::

## Problem 3c: Tangent

::: {#v24-oppg3c .ai-context}
Find the equation of the tangent to the function

$$h(x)=x\ln x$$

through the point $\left(e,h(e)\right)$. Give the answer with exact values.
:::

```{math-exercise}
#| label: v24-3c-svar
#| caption: 3c · Final answer
#| vars: x
#| field-labels: y
#| mode: custom
#| context: none
#| checker: |
#|   T = {
#|       "right": "Correct: the line has the right slope and passes through (e, h(e)).",
#|       "exact": "The line is right, but the problem asks for exact values. Write e instead of a decimal number.",
#|       "slope": "The line passes through (e, h(e)), but the slope is wrong. The slope is h′(e): check the derivative of x·ln x (product rule).",
#|       "point": "The slope is right, but the line does not pass through (e, h(e)). Check h(e) and the one-point formula.",
#|       "line": "A tangent is a straight line. Write it in the form y = ax + b.",
#|       "symbols": "Use only x and the number e in the answer: write the right-hand side of y = ….",
#|       "wrong": "This is not the tangent. Find the slope h′(e) and the point (e, h(e)), and use the one-point formula y − y₁ = a(x − x₁).",
#|   }
#|   def check(response, symbols):
#|       x = symbols["x"]
#|       f = response["expressions"][0].subs(Symbol("e"), E)
#|       if not f.free_symbols <= {x}:
#|           return {"score": 0, "feedback": T["symbols"]}
#|       try:
#|           if diff(f, x, 2) != 0:
#|               return {"score": 0, "feedback": T["line"]}
#|           slope, through = N(diff(f, x)), N(f.subs(x, E) - E)
#|       except (TypeError, ValueError):
#|           return {"score": 0, "feedback": T["wrong"]}
#|       slope_ok, through_ok = abs(slope - 2) < 1e-6, abs(through) < 1e-6
#|       if slope_ok and through_ok:
#|           if f.has(Float):
#|               return {"score": 0.5, "feedback": T["exact"]}
#|           return {"score": 1, "feedback": T["right"]}
#|       if through_ok:
#|           return {"score": 0, "feedback": T["slope"]}
#|       if slope_ok:
#|           return {"score": 0, "feedback": T["point"]}
#|       return {"score": 0, "feedback": T["wrong"]}
#| tests: _includes/logaritmer/tests/3c.py

$y=$ __[]
```

::: {.ai-feedback #v24-3c profile="mathematics" image-upload="true" image-role="response" context="v24-oppg3c" reset-on-variant="v24-3c-fyll"}
**Show your working for 3c.** Upload a photo of what you wrote on paper.
:::
