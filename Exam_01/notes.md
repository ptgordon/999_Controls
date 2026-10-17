# EE 474 Exam 1 — Notes

## FRONT — Modeling

### 5 steps
1. **Setup**: schematic, signal + parameter tables (units!), constituent eqs
2. **Continuity**: FBD + $m\ddot x=\sum F$ / KCL, KVL → governing ODEs
3. **Standard form**: output left, inputs right
4. **TF**: LT ($d/dt\to s$), eliminate internals, clear inner fractions, rat-poly form
5. **Units**: all terms in a sum match; TF = [out]/[in]

### Units

| Signal | Units | | Signal | Units |
|---|---|---|---|---|
| $v(t)$ voltage | V | | $i(t)$ current | A |
| $x(t)$ position | m | | $F(t)$ force | N |
| $\dot x = v$ velocity | m/s | | $\ddot x$ accel | m/s² |
| $\theta(t)$ angle | rad | | $T(t), M(t)$ torque | N·m |
| $\dot\theta=\omega$ ang. vel. | rad/s | | $\ddot\theta$ ang. accel | rad/s² |
| $E_b, E_c$ back-EMF | V | | power | W |
| pressure | Pa = N/m² | | fluid flow | m³/s |
| temperature | °C or K | | heat flow | W |

| Parameter | Equation | Units |
|---|---|---|
| Mass $m$ | $m\ddot x = f_{net}$ | kg = N·s²/m |
| Spring $k$ | $f_k = k(x_1-x_2)$ | N/m |
| Damper $b$ | $f_b = b(\dot x_1-\dot x_2)$ | N·s/m |
| Inertia $J, I$ | $J\ddot\theta = M_{net}$ | kg·m² = N·m·s²/rad |
| Rot. spring $k$ | $M_k = k(\theta_1-\theta_2)$ | N·m/rad |
| Rot. damper $b$ | $M_b = b(\dot\theta_1-\dot\theta_2)$ | N·m·s/rad |
| Resistor $R$ | $v = Ri$ | Ω = V/A |
| Inductor $L$ | $v = L\,di/dt$ | H = V·s/A |
| Capacitor $C$ | $i = C\,dv/dt$ | F = A·s/V |
| Torque const $k_t$ | $T_m = k_t i_a$ | N·m/A |
| Back-EMF const $k_e$ | $E_b = k_e\dot\theta$ | V·s/rad |
| Linear motor $k_t$, $k_e$ | $F = k_t i$, $E = k_e\dot x$ | N/A, V·s/m |

- N = kg·m/s²
- rad is dimensionless; $s$ has units 1/s
- W = V·A = N·m/s = J/s
- T = N/(A·m); Wb = V·s
- $L/R$, $J/b$, $RC$ are in seconds
- **$k_e = k_t$ in SI units** (same number, equivalent units):
  - Units: V·s/rad = (W/A)·s = (N·m/s)(s)/A = N·m/A
  - Why: back-EMF power = shaft power, $E_b i = T_m\omega$ → $k_e\omega i = k_t i\omega$
  - Linear motor: both equal $Bl$ (Bli and Blu laws)
  - Not equal if a datasheet uses V/krpm or oz·in/A

### Sign rules
- FBD: + in direction $x$/$\theta$ is measured; body 1 gets $-k(x_1-x_2)$, body 2 gets $+k(x_1-x_2)$; wall: $x_2=0$
- KCL: + out of node; KVL: + entering at '+'; passive sign convention
- Op-amp: $V^+=V^-$, no input current → virtual ground
- Bli: $F=Bli$ → $k_t$; Blu: $E=Blu$ → $k_e$

### DC motor
- $L_a\dot i_a + R_ai_a = V_a - k_e\dot\theta$
- $J\ddot\theta + b\dot\theta + k\theta = k_ti_a$ (drop terms not in figure)

$$\frac{\Theta}{V_a} = \frac{k_t}{(L_as+R_a)(Js^2+bs+k) + k_tk_es}$$

- Spring, no damper: $\frac{k_t}{L_aJs^3 + R_aJs^2 + (L_ak+k_tk_e)s + R_ak}$ → units rad/V
- No spring: $\frac{k_t}{s[(L_as+R_a)(Js+b)+k_tk_e]}$
- Reduced ($L_a\approx0$): $J\ddot\theta + (b+\frac{k_tk_e}{R_a})\dot\theta = \frac{k_t}{R_a}V_a$
- Voice coil: same with $M$, $x$

### Through / across

| Domain | Across (≈ V) | Through (≈ I) | Capacitor (stores across) | Resistor | Inductor |
|---|---|---|---|---|---|
| Electrical | $v$ [V] | $i$ [A] | $C$ | $R$ | $L$ |
| Translational | $\dot x$ [m/s] | $F$ [N] | mass $C=M$ | $R = 1/b$ | spring $L = 1/k$ |
| Rotational | $\dot\theta$ [rad/s] | $T$ [N·m] | inertia $C=J$ | $R=1/b$ | $L=1/k$ |
| Fluid | pressure | volume flow | tank | pipe friction | fluid inertia |
| Thermal | temperature | heat flow | thermal mass | thermal resistance | (none) |

- Through = flow over an area; across = measured between two points
- Firestone: velocity → V, force → I, force source → current source
- **Equivalent circuit**: 1 node per mass (wall = ground); $C=M$ to ground; spring/damper between their nodes (or to ground if on a wall); KCL = Newton

### Part 1 terms
- Open loop ignores output; closed loop acts on $e = r - y_s$
- Feedback rejects disturbances; high gain → small error but instability
- Performance: speed, accuracy, stability, robustness

---

## BACK — TFs, Laplace, PFE

### TF basics
- $G = Y/U$, zero ICs, LTI only, depends only on parameters
- ODE ↔ TF: coefficients map directly, $\frac{d^n}{dt^n}\to s^n$
- Poles = denominator roots, zeros = numerator roots; complex → conjugate pairs
- Root-locus form: highest coeffs = 1 ($K_{rlg}$); Bode form: lowest coeffs = 1 ($K_{Bode}$)
- $K_{DC} = G(0) = b_0/a_0$

### Closed loop
$$T = \frac{\text{forward path}}{1 + G_cG_pH_y}$$

| TF | Numerator | | TF | Numerator |
|---|---|---|---|---|
| $T_{ry}$ | $G_cG_p$ | | $T_{dy}$ | $G_p$ |
| $T_{re}$ | $1$ | | $T_{de}$ | $-G_pH_y$ |
| $T_{ru}$ | $G_c$ | | $T_{du}$ | $-G_cG_pH_y$ |

- $Y = T_{ry}R + T_{dy}D$ (set other input to 0)
- Series $G_1G_2$; parallel $G_1+G_2$; feedback $\frac{G}{1+GH}$
- Pole placement: match monic char. poly to $\prod(s-p_i)$

### Laplace
- Derivative: $sF$; integral: $F/s$; linear
- FVT (stable): $y_{ss} = \lim_{s\to0}sY$; step → $K_{DC}$

| $f(t)$, $t \ge 0$ | $F(s)$ |
|---|---|
| $\delta(t)$ | $1$ |
| $1^+(t)$ | $1/s$ |
| $t\,1^+(t)$ | $1/s^2$ |
| $e^{-\alpha t}$ | $\frac{1}{s+\alpha}$ |
| $\sin\omega t$ / $\cos\omega t$ | $\frac{\omega}{s^2+\omega^2}$ / $\frac{s}{s^2+\omega^2}$ |
| $e^{-\alpha t}(B_c\cos\omega t + B_s\sin\omega t)$ | $\frac{B_cs + (B_c\alpha + B_s\omega)}{s^2+2\alpha s+\omega_n^2}$, with $\omega_n^2 = \alpha^2+\omega^2$ |

- Impulse response: $U=1$ so $Y=G$

### LT vs TF

| Statement | L.T. | T.F. |
|---|:-:|:-:|
| Derived from a system description / **depends on system parameters** | | ✓ |
| Derived from a time-domain signal | ✓ | |
| **Has an inverse** | ✓ | |
| Has units | ✓ | ✓ |
| **Is a rational polynomial** | ✓ | ✓ |
| Formed as a ratio of LTs | | ✓ |
| Generally known to the controls engineer | | ✓ |
| Time function found by PFE | ✓ (PFE *is* the inverse LT) | |

### PFE
- Monic, pull out $K_{rlg}$, find poles: $s=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$
- $Y=\sum\frac{C_i}{s-p_i}$ → $y=\sum C_ie^{p_it}$
- **Plug & chug**: common denominator, match powers of $s$
- **Cover-up**: $C_i = [(s-p_i)Y]_{s=p_i}$
- **Graphical**: $C_i = K_{rlg}\frac{\prod(\text{zeros}\to p_i)}{\prod(\text{other poles}\to p_i)}$, polar: × mags, + angles; use atan2
- **Complex pair** $-\alpha\pm j\omega$, $C=c_r+jc_j$: $y = 2|C|e^{-\alpha t}\cos(\omega t+\angle C) = e^{-\alpha t}(2c_r\cos\omega t - 2c_j\sin\omega t)$
- Check: $\sum C_i = K_{rlg}$ if degree gap is 1

### Complex numbers / s-plane
- $M=\sqrt{a^2+b^2}$, $\theta=\text{atan2}(b,a)$; $e^{j\theta}=\cos\theta+j\sin\theta$
- LHP stable; RHP unstable; $j\omega$ axis marginal; farther left = faster
- Pole sets shape, residue sets size; step's pole at 0 has residue $K_{DC}$

### Exam habits
- Complete sentences for essays; units everywhere; final TF in rat-poly form
