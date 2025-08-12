using Polynomials, Plots, SpecialFunctions

include("pswf.jl")

tol = 1e-4
order = 15
r_c = 10.0
sigma = r_c * sqrt(- 1 / log(tol))

ep = Polynomial(reverse(energy_poly(tol, order)))
fcp = Polynomial(reverse(force_poly(tol, order)))
fp = Polynomial(reverse(fourier_poly(tol, order)))

c = prolc180(tol)
lambda = prolate0_lambda(c)

f_prolate = x -> prolate0_eval(c, x)
f_prolate_derivative = x -> prolate0_eval_derivative(c, x)
f_prolate_integral = x -> prolate0_int_eval(c, x)


C0 = f_prolate_integral(1.0)
f_near_prolate = x -> 1 - f_prolate_integral(x / r_c) / C0
f_near_erfc = x -> erfc(x / sigma)

xs = range(0.0, r_c, length=1000)
plot(xs, f_near_prolate.(xs), label="prolate")
plot!(xs, f_near_erfc.(xs), label="erfc")


ks = range(0.0, 10.0, length=1000)

f_fourier_prolate = x -> 2π * lambda * f_prolate(x * r_c / c) / C0
f_fourier_erfc = x ->  4 * π * exp(- (x / sigma)^2 / 4)

plot(xs, f_fourier_prolate.(xs), label="prolate")
plot!(xs, f_fourier_erfc.(xs), label="exp(-x^2 / 4σ^2)")