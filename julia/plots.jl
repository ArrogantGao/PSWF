using Polynomials, Plots

include("pswf.jl")

tol = 1e-4
order = 15
ep = Polynomial(reverse(energy_poly(tol, order)))
fcp = Polynomial(reverse(force_poly(tol, order)))
fp = Polynomial(reverse(fourier_poly(tol, order)))

c = prolc180(tol)

f_prolate = x -> prolate0_eval(c, x)
f_prolate_derivative = x -> prolate0_eval_derivative(c, x)
f_prolate_integral = x -> prolate0_int_eval(c, x) / prolate0_int_eval(c, 1.0)
f_energy = x -> ep(x)
f_force = x -> fcp(x)
f_fourier = x -> fp(x)

d_ep = derivative(ep)
f_energy_derivative = x -> d_ep(x)

xs = range(0.0, 1.0, length=1000)

plot(xs, f_prolate.(xs), label="prolate")
plot!(xs, f_prolate_derivative.(xs), label="prolate derivative")

plot(xs, f_prolate_integral.(xs), label="prolate integral")

plot(xs, f_energy.(xs), label="energy")
# plot!(xs, f_energy_derivative.(xs) ./ f_energy_derivative(0.0), label="energy derivative")
plot!(xs, f_force.(xs) ./ f_force(0.0), label="force")

plot(xs, f_prolate.(xs) ./ f_prolate(0.0), label="prolate")
plot!(xs, f_fourier.(xs) ./ f_fourier(0.0), label="fourier")