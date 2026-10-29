## Oppgave 1b: Forenkling

::: {#v24-oppg1b .ai-context}
Skriv så enkelt som mulig.

$$\frac{a\cdot\ln b-\ln b^2}{(a-2)\cdot\ln\sqrt{b}}$$
:::

```{math-exercise}
#| label: v24-1b-svar
#| caption: 1b · Svar
#| vars: a, b
#| field-labels: Det forenklede uttrykket
#| mode: custom
#| context: none
#| checker: |
#|   T = {
#|       "right": "Riktig, og så enkelt som mulig.",
#|       "simplify": "Uttrykket ditt er lik det opprinnelige, men det kan forenkles mer. Se etter en felles faktor i telleren og nevneren.",
#|       "wrong": "Dette er ikke lik det opprinnelige uttrykket. Sjekk logaritmereglene: både ln b² og ln √b kan skrives med ln b, og a·ln b er ikke ln(ab).",
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

Forenklet uttrykk: __[]
```

::: {.ai-feedback #v24-1b profile="mathematics" image-upload="true" image-role="response" context="v24-oppg1b" reset-on-variant="v24-1b-fyll"}
**Vis utregningen din for 1b.** Last opp et bilde av det du skrev på papiret.
:::

## Oppgave 3b: Derivasjon

::: {#v24-oppg3b .ai-context}
Deriver funksjonen og forenkle svaret mest mulig.

$$g(x)=\frac{1}{2}\ln\left(2x^2-2x^4\right)$$
:::

```{math-exercise}
#| label: v24-3b-svar
#| caption: 3b · Svar
#| vars: x
#| field-labels: g′(x)
#| mode: custom
#| context: none
#| checker: |
#|   T = {
#|       "right": "Riktig, og skrevet som én forenklet brøk.",
#|       "one_fraction": "Den deriverte er riktig, men skriv den som én brøk.",
#|       "common_factor": "Den deriverte er riktig, men telleren og nevneren har fortsatt en felles faktor. Forenkle mer.",
#|       "inner": "Sjekk kjerneregelen: den deriverte av ln u er u′/u. Ganget du med den deriverte av kjernen u?",
#|       "half": "Nesten: sjekk hva som skjer med faktoren ½ foran logaritmen.",
#|       "outer": "Du har den deriverte av kjernen, men den deriverte av ln u er u′/u. Hva må du dele på?",
#|       "wrong": "Dette er ikke g′(x). Bruk kjerneregelen (den deriverte av ln u er u′/u) og ta med faktoren ½.",
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
**Vis utregningen din for 3b.** Last opp et bilde av det du skrev på papiret.
:::

## Oppgave 3c: Tangent

::: {#v24-oppg3c .ai-context}
Finn likningen for tangenten til funksjonen

$$h(x)=x\ln x$$

gjennom punktet $\left(e,h(e)\right)$. Oppgi svaret med eksakte verdier.
:::

```{math-exercise}
#| label: v24-3c-svar
#| caption: 3c · Svar
#| vars: x
#| field-labels: y
#| mode: custom
#| context: none
#| checker: |
#|   T = {
#|       "right": "Riktig: linja har riktig stigningstall og går gjennom (e, h(e)).",
#|       "exact": "Linja er riktig, men oppgaven ber om eksakte verdier. Skriv e i stedet for et desimaltall.",
#|       "slope": "Linja går gjennom (e, h(e)), men stigningstallet er feil. Stigningstallet er h′(e): sjekk den deriverte av x·ln x (produktregelen).",
#|       "point": "Stigningstallet er riktig, men linja går ikke gjennom (e, h(e)). Sjekk h(e) og ettpunktsformelen.",
#|       "line": "En tangent er en rett linje. Skriv den på formen y = ax + b.",
#|       "symbols": "Bruk bare x og tallet e i svaret: skriv høyresiden i y = ….",
#|       "wrong": "Dette er ikke tangenten. Finn stigningstallet h′(e) og punktet (e, h(e)), og bruk ettpunktsformelen y − y₁ = a(x − x₁).",
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
**Vis utregningen din for 3c.** Last opp et bilde av det du skrev på papiret.
:::
