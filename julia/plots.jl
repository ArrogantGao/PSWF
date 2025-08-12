using Polynomials, CairoMakie, SpecialFunctions

include("pswf.jl")

tol = 1e-4
order = 15


ep = Polynomial(reverse(energy_poly(tol, order)))
fcp = Polynomial(reverse(force_poly(tol, order)))
fp = Polynomial(reverse(fourier_poly(tol, order)))

c = prolc180(tol)
lambda = prolate0_lambda(c)

f_prolate = x -> prolate0_eval(c, x)
f_prolate_derivative = x -> prolate0_eval_derivative(c, x)
f_prolate_integral = x -> prolate0_int_eval(c, x)
C0 = f_prolate_integral(1.0)



r_c = 1.0
sigma = r_c * sqrt(- 1 / log(tol))

f_near_prolate = x -> 1 - f_prolate_integral(x / r_c) / C0
f_near_erfc = x -> erfc(x / sigma)

f_fourier_prolate = x -> 2π * lambda * f_prolate(x * r_c / c) / C0
f_fourier_prolate_poly = x -> 2π * fp(x * r_c / c)
f_fourier_erfc = x ->  4 * π * exp(- (x * sigma)^2 / 4)

begin
    fig = Figure(size = (1000, 400), fontsize = 20, dpi = 500)
    ax1 = Axis(fig[1, 1], xlabel = "r", yscale = log10, title = "Near field")
    ax2 = Axis(fig[1, 2], xlabel = "k", yscale = log10, title = "Far field")

    xs = range(0.0, r_c, length=1000)
    lines!(ax1, xs, f_near_prolate.(xs), label="PSWF")
    lines!(ax1, xs, f_near_erfc.(xs), label="Guassian")

    ks = range(0.0, 1.6 * c / r_c, length=1000)
    lines!(ax2, ks, f_fourier_prolate.(ks), label="PSWF")
    lines!(ax2, ks, f_fourier_erfc.(ks), label="Ewald")

    axislegend(ax1, position = :lb)

    save("comparison.png", fig)

    fig
end