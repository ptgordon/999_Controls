# EE 474 Final Exam — Notes

## Root Locus (Part 9)

### Setup
- Char. eq: $a(s) + K_{rlg}\,b(s) = 0$, $G_L(s) = b(s)/a(s)$; $n$ poles, $m$ zeros
- **Angle condition**: $\sum\angle(\text{zeros}\to s) - \sum\angle(\text{poles}\to s) = 180° + 360°(l-1)$
- Every point on the locus obeys it; every rule below falls out of it

### Rules (§3.4, p. 9-29)
1. $n$ branches start at the poles; $m$ end at the zeros
2. Real axis is on the locus **left of an odd number** of real poles + zeros
   - 2.a Symmetric about the real axis (conjugate pairs)
3. $n-m$ branches go to $\infty$ along asymptotes
   - Centroid $\alpha_c = \dfrac{\sum \text{poles} - \sum \text{zeros}}{n-m}$
   - Angles $\phi = \dfrac{180° + 360°(l-1)}{n-m}$, $l = 1\ldots n-m$
4. Departure / arrival angles at complex poles / zeros (below)
5. $q$ branches meeting at a point are spaced $\dfrac{180° + 360°(l-1)}{q}$; $q=2$ → break in/out at $\pm 90°$

### Rule 4 — departure / arrival
- Idea: stand just next to pole $p_k$. Every other angle ≈ its angle to $p_k$ (fixed), so the only free angle is the step direction. Choose it to satisfy the angle condition.
- **Departure, single pole**: $\phi_{dep} = \sum\psi_{zeros} - \sum\phi_{other\ poles} - 180°$
- **Arrival, single zero**: $\psi_{arr} = \sum\phi_{poles} - \sum\psi_{other\ zeros} + 180°$
- **Repeated ($q$-fold) pole**: $q\,\phi_{dep} = \sum\psi - \sum\phi_{other} - (180° + 360°(l-1))$
  - Solve for $q\phi$, divide by $q$, branches spaced $360°/q$ ($q=2$ → opposite directions)
  - $q$ is the multiplicity of the pole you are **leaving**, not the others
- −180° ≡ +180° (textbooks write +180°)
- Signs: zeros $+$, poles $-$, and the step direction counts as a pole ($-$). All-plus shortcut ($\sum\phi + x = 180°$) only works with **no zeros**.

**Examples** — departure from $-1+j$:

| Poles | Angles to $-1+j$ | Equation | $\phi_{dep}$ |
|---|---|---|---|
| $0,\ -1\pm j$ | $0$: 135°, $-1-j$: 90° | $-(135+90) - 180$ | $-45°$ |
| $0^2,\ -1\pm j$ | $0$: 135° ×2, $-1-j$: 90° | $135+135+90+x = 180$ | $180°$ |
| $0,\ (-1\pm j)^2$ | $0$: 135°, $-1-j$: 90° ×2 | $90+90+135+2x = 180$ | $-67.5°,\ 112.5°$ |

## Controller design (Part 9 §4)

### Standard structures (Table 1, p. 9-38)

| Structure | $G_c(s)$ | Zeros / poles added | Use |
|---|---|---|---|
| P | $k_p$ | — | |
| PD | $k_d s + k_p$ | 1 zero | position control, so-so accuracy |
| PI | $\dfrac{k_p s + k_i}{s}$ | 1 zero, pole at 0 | motor velocity, temperature |
| PID | $\dfrac{k_d s^2 + k_p s + k_i}{s}$ | 2 zeros, pole at 0 | ~80% of loops |
| Lead | $K_c\dfrac{s+z_1}{s+p_1}$, $\lvert z_1\rvert<\lvert p_1\rvert$ | like PD, less HF noise | |
| Lag | $K_c\dfrac{s+z_1}{s+p_1}$, $\lvert z_1\rvert>\lvert p_1\rvert$ | like PI, no pole at 0 | |
| Lead-lag | $K_c\dfrac{(s+z_1)(s+z_2)}{(s+p_1)(s+p_2)}$ | like PID, no pole at 0 | 5 params |

### Introducing a double zero
- Use the **controller**. PID: $G_c = \dfrac{k_d(s^2 + \frac{k_p}{k_d}s + \frac{k_i}{k_d})}{s}$
- Double zero at $-z$: numerator $= k_d(s+z)^2$ → **$k_p = 2k_d z$, $k_i = k_d z^2$**
- Discriminant: $k_p^2 = 4k_dk_i$ double real; $>$ two distinct real; $<$ complex pair
- Bare $(s+z)^2$ is improper (more zeros than poles), so it can't be built and it amplifies noise. Poles always come with it:
  - PID → pole at origin
  - Lead-lag with $z_1=z_2$ → two poles $p_1, p_2$
  - Two lead stages → $(s+z)^2/(s+p)^2$, $p$ far left
- Effect: pulls 2 branches in, $n-m$ drops by 2 (fewer asymptotes); arrival at double zero is $q=2$, branches 180° apart
