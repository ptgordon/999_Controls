# EE 474 Exam 1 — Notes Sheet

Covers Part 1, Part 2, Part 3 and Part 3b, through the partial fraction
expansion methods. Ordered by how much the review exam leans on each topic:
modeling (40 pts), transfer function → ODE → impulse response (20),
closed-loop TFs (20), LT vs TF (20), dynamic equivalent circuit (EC 15).

---

## FRONT — Modeling

### 1. The 5-step modeling procedure (Problem 1 follows it exactly)

1. **Set up the model**
   - Draw a schematic and assign a variable to every signal: positions for every
     moving mass; a voltage and current for every electrical element.
   - **Tables of signals and of parameters**, each with symbol, units and description.
   - **Constituent equations**: one per element.
2. **Continuity equations** (how the elements connect)
   - Mechanical: a **free body diagram** of each mass, then Newton's law,
     $m\ddot x = \sum F$.
   - Electrical: KCL (currents out of a node sum to 0) and KVL (voltages
     around a loop sum to 0).
   - Combine with the constituent equations to get the governing ODEs.
3. **Standard form**: output signal and its derivatives on the **left**, inputs on the **right**.
4. **Transfer function**: take the LT (zero ICs, $d/dt \to s$), eliminate the
   internal signals, clear the fractions within the fraction, and multiply out
   to **rational-polynomial form**.
5. **Validate units**: every term of a sum has the same units, and the TF has
   units of [output]/[input].

### 2. Units

**Signals**

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

**Parameters**

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

**Unit identities**
- $1\,\text{N} = 1\,\text{kg·m/s}^2$, so $1\,\text{kg} = 1\,\text{N·s}^2/\text{m}$ and $1\,\text{kg·m}^2 = 1\,\text{N·m·s}^2$.
- **Radians are dimensionless.**
- $s$ has units of **1/s**.
- $1\,\text{W} = 1\,\text{V·A} = 1\,\text{N·m/s} = 1\,\text{N·m·rad/s} = 1\,\text{J/s}$.
- $1\,\text{T} = 1\,\text{N/(A·m)} = 1\,\text{Wb/m}^2$, and $1\,\text{Wb} = 1\,\text{V·s}$.
- **$k_e = k_t$** in SI units, by conservation of energy. Both work out to J/(A·m), or J/(A·rad) for a rotary motor.
- Time constants: $L/R$ and $J/b$ are in seconds, and so is $RC$.

### 3. Constituent equations

- **Mechanical**: $f = m\ddot x$, $f = kx$, $f = b\dot x$. The rotational forms are the same with $J$, $\theta$ and $M$.
- **Electrical**: $v_R = Ri$, $v_L = L\,\dot i$, $i_C = C\,\dot v$, plus the voltage and current sources.
  - **Passive sign convention**: the current arrow points into the '+' terminal of the element's voltage.
- **Op-amp** with negative feedback: $V^+ = V^-$, and no current flows into the inputs.
  - With $V^+$ grounded, the '−' input is a **virtual ground**.
  - Inverting low-pass example: $G = -R_2/(R_1R_2C_1 s + R_1)$.
- **Electromechanical**:
  - Field from a current: $B = \mu i/(2\pi d)$.
  - **Bli law**, force on a current: $F = B\,l\,i$.
  - **Blu law**, EMF from motion: $E = B\,l\,u$.
  - Linear (voice-coil) motor: $F_c = k_t i_a$ and $E_c = k_e\dot x$.
  - DC motor: $T_m = k_t i_a$ and $E_b = k_e\dot\theta$.

### 4. Continuity: sign rules

- In an FBD, the net force (or moment) is positive **in the direction $x$ (or $\theta$) is measured**.
- A spring or damper between bodies 1 and 2 pushes body 1 with $-k(x_1-x_2)$ and body 2 with $+k(x_1-x_2)$.
- A spring or damper tied to a wall or ground uses $x_2 = 0$.
- KCL: a current is **+ if its arrow points out of the node**.
- KVL: a voltage is **+ if the loop enters the element at its '+' side**.

### 5. DC motor template (Problem 1)

- Electrical (KVL): $L_a\dot i_a + R_a i_a = V_a - k_e\dot\theta$
- Mechanical (FBD): $J\ddot\theta + b\dot\theta + k\theta = k_t i_a$. Drop $b$ or $k$ if the figure doesn't show them.
- In the frequency domain:
  - $(L_a s + R_a)I_a = V_a - k_e s\Theta$
  - $(Js^2 + bs + k)\Theta = k_t I_a$, so $I_a = \frac{Js^2+bs+k}{k_t}\Theta$
- Transfer function:

$$\frac{\Theta(s)}{V_a(s)} = \frac{k_t}{(L_a s+R_a)(Js^2+bs+k) + k_tk_e s}$$

- **With spring $k$ and no damper** (the exam case):
  $\dfrac{k_t}{L_aJ s^3 + R_aJ s^2 + (L_ak + k_tk_e)s + R_ak}$
  - Single ODE: $L_aJ\dddot\theta + R_aJ\ddot\theta + (L_ak+k_tk_e)\dot\theta + R_ak\,\theta = k_tV_a$
- **No spring**: $\dfrac{k_t}{s\,[(L_as+R_a)(Js+b) + k_tk_e]}$. The pole at the origin means a position output.
- **Reduced order** (when $L/R \ll J/b$, drop $L_a$):
  $J\ddot\theta + (b + \frac{k_tk_e}{R_a})\dot\theta = \frac{k_t}{R_a}V_a$
- **AC induction motor**: $T_m = K_1V_a - K_2\dot\theta$, so $J\ddot\theta + (b+K_2)\dot\theta = K_1V_a$.
- **Units check**: every denominator term is (V/A)(N·m). The numerator $k_t$ is N·m/A. So $G$ = **1/V = rad/V** ✓.
- Voice-coil motor: identical form with $M$ and $x$ in place of $J$ and $\theta$.
- Quarter-car TF $Y/R$ is **dimensionless** (m/m).

### 6. Through and across variables, and analog circuits

**Through** variables are a flow, integrated over an area: current, force, torque, fluid flow, heat flow.
**Across** variables are measured between two points or against a reference: voltage, velocity, angular velocity, pressure, temperature.

| Domain | Across (≈ V) | Through (≈ I) | Capacitor (stores across) | Resistor | Inductor |
|---|---|---|---|---|---|
| Electrical | $v$ [V] | $i$ [A] | $C$ | $R$ | $L$ |
| Translational | $\dot x$ [m/s] | $F$ [N] | mass $C=M$ | $R = 1/b$ | spring $L = 1/k$ |
| Rotational | $\dot\theta$ [rad/s] | $T$ [N·m] | inertia $C=J$ | $R=1/b$ | $L=1/k$ |
| Fluid | pressure | volume flow | tank | pipe friction | fluid inertia |
| Thermal | temperature | heat flow | thermal mass | thermal resistance | (none) |

- **The Firestone (mobility) analogy**, used in this course, maps across to across and through to through:
  - velocity → **voltage**, force/torque → **current**
  - **mass → capacitor to ground** (a mass's velocity is measured against the inertial reference)
  - **damper → resistor $1/b$**, **spring → inductor $1/k$**
  - **applied force → current source**, imposed velocity → voltage source
- Element laws, side by side:
  - $F = M\dot v \;\leftrightarrow\; i = C\dot v$
  - $F = bv \;\leftrightarrow\; i = v/R$
  - $F = k\!\int v\,dt \;\leftrightarrow\; i = \frac1L\!\int v\,dt$
- **Recipe for a dynamic equivalent circuit** (Extra Credit):
  1. **Each mass is one non-ground node**, with voltage equal to its velocity. A wall or base is ground.
  2. Each mass gets a capacitor $C = M$ to ground.
  3. A spring or damper between two masses goes **between their nodes**. One attached to a wall or base goes from the node **to ground**.
  4. An applied force is a current source into that mass's node.
  5. Count the R, C and L elements and the nodes. KCL at each node reproduces Newton's law for that mass.
- **The other analogy, for reference only** (force–voltage): mass → L, spring → $C = 1/k$, damper → $R=b$, force → voltage source. Don't mix the two.
- Stored energy is what makes a system dynamic: $\frac{d}{dt}(\text{stored}) = \text{flow}$. For example, $E = \frac12 Mv^2$ and $\dot E = vF$; $E = \frac12 Cv^2$ and $\dot E = vi$.

### 7. Part 1 vocabulary (for essay answers)

- **Signals** are functions of time, not known in advance, and describe what is happening.
- **Parameters** are constants that describe components; the engineer chooses the controller's parameters.
- **Open loop**: the control action ignores the output (a gas stove).
- **Closed loop**: the controller acts on the error $e = r - y_s$ (a thermostat or cruise control).
- **Feedback** greatly reduces the effect of disturbances. High gain gives small error, but too much gain causes **instability**.
- **Performance measures**: speed, accuracy, stability (damping) and robustness, which trade off against each other.
- **Block diagrams**: blocks process signals, circles are summing junctions, and lines are signals. Both blocks and lines have units, and the arrows show causality.
- Terms: plant $G_p$, controller $G_c$, actuator, sensor $H_y$, reference $r$, error $e$, control $u$, disturbance $d$/$w$, sensor noise.

---

## BACK — Transfer functions, Laplace, PFE

### 8. Transfer function basics

- **Definition**: $G(s) = Y(s)/U(s)$, the output LT over the input LT with zero initial conditions. Its units are **[output]/[input]**, a "generalized gain".
- It exists only for **linear (LTI)** systems, and depends **only on the system parameters**, not on the signals.
- **ODE ↔ TF**: each derivative becomes a power of $s$, coefficient for coefficient. Example:
  - $a_2\ddot y + a_1\dot y + a_0y = b_1\dot u + b_0u$
  - $\Leftrightarrow\; G = \dfrac{b_1s+b_0}{a_2s^2+a_1s+a_0}$
- **Poles** are the roots of the denominator; **zeros** are the roots of the numerator. The order is the number of poles.
- Complex roots always come in **conjugate pairs**, because the coefficients are real.
- **Forms**:
  - **Rational polynomial**, the standard form for a TF.
  - **Root-locus**: $K_{rlg}\frac{s+b_0}{s^2+a_1s+a_0}$, with the *highest* coefficients equal to 1.
  - **Bode**: $K_{Bode}\frac{1}{s^{N_0}}\frac{b_1s+1}{a_2s^2+a_1s+1}$, with the *lowest* coefficients equal to 1.
  - **Sum-of-terms** (PFE): $\sum \frac{C_i}{s-p_i}$, which realizes the system as blocks in parallel.
  - **Product-of-terms**: $K_{rlg}\frac{\prod(s-z_i)}{\prod(s-p_i)}$, which realizes it as blocks in series.
- **DC gain**: $K_{DC} = \lim_{s\to0}G(s) = b_0/a_0$.
- **Clear fractions within fractions** by multiplying the top and bottom by every inner denominator.

### 9. Closed-loop TFs (Problem 3)

$$T = \frac{\text{forward-path gain}}{1 + \text{loop gain}}, \qquad \text{loop gain} = G_cG_pH_y$$

The loop is $r \to e \to G_c \to (+d) \to G_p \to y$, with $y \to H_y \to (-)$ back to the summing junction.

| TF | Numerator | | TF | Numerator |
|---|---|---|---|---|
| $T_{ry}$ | $G_cG_p$ | | $T_{dy}$ | $G_p$ |
| $T_{re}$ | $1$ | | $T_{de}$ | $-G_pH_y$ |
| $T_{ru}$ | $G_c$ | | $T_{du}$ | $-G_cG_pH_y$ |

- All of them share the denominator $1 + G_cG_pH_y$.
- **Superposition**: $Y = T_{ry}R + T_{dy}D$. Find each TF with the other input set to 0.
- **Derive by signals**: write $E = R - H_yY$ and $Y = G_p(D + G_cE)$, eliminate the internal signal, and collect the output on the left.
- **Block algebra**:
  - series: $G_1G_2$
  - parallel: $G_1+G_2$
  - feedback: $\frac{G}{1+GH}$
  - moving a pick-off point or summing junction past $G$ multiplies that branch by $G$ or $1/G$
- **Exam Problem 3 answers**:
  - $T_{ry} = \dfrac{k_p(2s+3)(0.1s+1)}{s(2s+1)(0.1s+1)+k_p(2s+3)}$
  - $T_{de} = \dfrac{-(2s+3)}{\text{same denominator}}$
- **Pole placement**:
  1. Write the closed-loop characteristic polynomial in monic form.
  2. Pick the desired poles and expand $\prod(s-p_i)$.
  3. Match the coefficients of each power of $s$ and solve for the gains.

### 10. Laplace transform

- $F(s) = \int_{0^-}^\infty f(t)e^{-st}dt$, one-sided, with $f = 0$ for $t<0$.
- **Linearity** (superposition and scaling).
- **Derivative**: $\mathcal L\{\dot f\} = sF - f(0^-)$, which is just $sF$ with zero ICs. Likewise $\mathcal L\{f^{(m)}\} = s^mF$.
- **Integral**: $\mathcal L\{\int_0^t f\} = F/s$.
- **Final Value Theorem** (stable systems only): $y_{ss} = \lim_{s\to0} sY(s)$.
  - For a step input, $y_{ss} = K_{DC}$ and $e_{ss} = 1 - K_{DC}$.

| $f(t)$, $t \ge 0$ | $F(s)$ |
|---|---|
| $\delta(t)$ | $1$ |
| $1^+(t)$ | $1/s$ |
| $t\,1^+(t)$ | $1/s^2$ |
| $e^{-\alpha t}$ | $\frac{1}{s+\alpha}$ |
| $\sin\omega t$ / $\cos\omega t$ | $\frac{\omega}{s^2+\omega^2}$ / $\frac{s}{s^2+\omega^2}$ |
| $e^{-\alpha t}(B_c\cos\omega t + B_s\sin\omega t)$ | $\frac{B_cs + (B_c\alpha + B_s\omega)}{s^2+2\alpha s+\omega_n^2}$, with $\omega_n^2 = \alpha^2+\omega^2$ |

- **Impulse response**: $u = \delta \Rightarrow U = 1 \Rightarrow Y(s) = G(s)$. This is the link between an LT and a TF.

### 11. LT vs TF (Problem 4; from Part 3b table, p. 3b-46)

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

- The same rational polynomial can be either one; **context decides** whether it is a signal (LT) or a system (TF).

### 12. Partial fraction expansion (inverse LT)

**Steps**:
1. Form $Y = GU$ in monic form and pull out $K_{rlg}$.
2. Find the poles (quadratic formula: $s = \frac{-b\pm\sqrt{b^2-4ac}}{2a}$).
3. Write $Y = \sum\frac{C_i}{s-p_i}$.
4. Find the residues $C_i$.
5. Each term becomes $C_ie^{p_it}$.

**Method 1: plug and chug.** Put the sum back over the common denominator, then match the coefficients of each power of $s$ and solve the linear equations.
- Example: $\frac{3}{(s+2)(s+3)}$ gives $C_1+C_2=0$ and $3C_1+2C_2=3$, so $C_1=3$, $C_2=-3$.
- The algebra grows quickly with the number of terms.

**Method 2: cover-up.** $C_i = \big[(s-p_i)Y(s)\big]_{s=p_i}$: cancel that pole's factor, then plug in $s = p_i$.
- Example: $3\frac{(s+2)(s+4)}{s(s+1)(s+3)}$ gives
  - $C_{0} = 3\cdot\frac{2\cdot4}{1\cdot3}=8$
  - $C_{-1} = 3\frac{1\cdot3}{(-1)(2)} = -\frac92$
  - $C_{-3} = 3\frac{(-1)(1)}{(-3)(-2)}=-\frac12$

**Method 3: graphical residue.**

$$C_i = K_{rlg}\frac{\prod \text{vectors from each zero to } p_i}{\prod \text{vectors from each *other* pole to } p_i}$$

- Each vector is $p_i - z_j$ (or $p_i - p_k$), written in polar form $M\angle\theta$.
- **Multiply** the magnitudes and **add** the angles; **divide** the magnitudes and **subtract** the angles.
- Use **atan2** for the angles, since a vector pointing left is at 90°–180°.
- It is the cover-up method done geometrically, and it is the basis of root locus.

**Complex pair**: $p = -\alpha \pm j\omega$ with residues $C = c_r + jc_j$ and $C^*$.

$$y(t) = e^{-\alpha t}\big(2c_r\cos\omega t - 2c_j\sin\omega t\big) = 2|C|\,e^{-\alpha t}\cos(\omega t + \angle C)$$

- $B_c = 2c_r$, $B_s = -2c_j$, $A = \sqrt{B_c^2+B_s^2}$, $\varphi = \text{atan2}(-B_s, B_c)$.
- The imaginary parts always cancel.
- Alternative: keep the pair as one quadratic term, $\frac{C_2s+C_3}{s^2+2\alpha s+\omega_n^2}$, and solve with plug and chug.

**Checks**:
- If the degree of the denominator exceeds the numerator's by exactly 1, then $\sum C_i = K_{rlg}$ (the leading coefficient of the numerator).
- Conjugate poles must have conjugate residues.
- Evaluating $y(0^+)$ should be consistent with the system.

**Exam Problem 2**:
- $\frac{3s+4}{2s^2+14s+20} = \frac32\frac{s+4/3}{(s+2)(s+5)}$
- $C_{-2} = -\frac13$ and $C_{-5} = \frac{11}{6}$
- $y = \frac{11}{6}e^{-5t} - \frac13e^{-2t}$
- ODE: $2\ddot y+14\dot y+20y = 3\dot u+4u$

### 13. Complex numbers

- $(a+jb)(c+jd) = (ac-bd) + j(ad+bc)$
- Divide by multiplying the top and bottom by the conjugate.
- $M = \sqrt{a^2+b^2}$, $\theta = \text{atan2}(b,a)$; $a = M\cos\theta$, $b = M\sin\theta$.
- Euler: $e^{j\theta} = \cos\theta + j\sin\theta$, $\cos\omega t = \frac{e^{j\omega t}+e^{-j\omega t}}{2}$, $\sin\omega t = \frac{e^{j\omega t}-e^{-j\omega t}}{2j}$.

### 14. Poles, modes and the s-plane

- Each real pole or complex pair is one **mode** $C_ie^{p_it}$. The **pole sets the shape** (speed, damping, stability); the **residue sets the size**.
- **LHP** is stable (decays), **RHP** is unstable (grows), the **$j\omega$ axis** is marginally stable.
  - Farther left means faster.
  - Larger $\omega$ relative to $\alpha$ means more oscillation.
- A pole at the origin from a step input is the DC term; its residue is $K_{DC}$.
- Modes of the **system** come from the poles of $G$; one extra term comes from $U(s)$.

### 15. Exam habits

- A calculation may be left as an expression, for example $\cos(a)$.
- Essay answers must be **complete sentences**.
- **Always give units** in the signal and parameter tables, and finish every derivation with a units check.
- Put the final TF in rational-polynomial form, with no fractions inside fractions.
