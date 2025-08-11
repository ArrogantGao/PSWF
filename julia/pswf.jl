const libpswf = joinpath(dirname(@__FILE__), "..", "build", "libPSWF.so")

function prolc180(eps::Float64)
    ccall((:prolc180, libpswf), Float64, (Float64,), eps)
end

function prolate0_eval(c::Float64, x::Float64)
    ccall((:prolate0_eval, libpswf), Float64, (Float64, Float64), c, x)
end

function prolate0_eval_derivative(c::Float64, x::Float64)
    ccall((:prolate0_eval_derivative, libpswf), Float64, (Float64, Float64), c, x)
end

function prolate0_int_eval(c::Float64, r::Float64)
    ccall((:prolate0_int_eval, libpswf), Float64, (Float64, Float64), c, r)
end

function energy_poly(tol::Float64, order::Int)
    coeffs = zeros(Float64, order)
    ccall((:energy_poly, libpswf), Cvoid, (Float64, Int, Ptr{Float64}), tol, order, coeffs)
    return coeffs
end

function force_poly(tol::Float64, order::Int)
    coeffs = zeros(Float64, order)
    ccall((:force_poly, libpswf), Cvoid, (Float64, Int, Ptr{Float64}), tol, order, coeffs)
    return coeffs
end

function fourier_poly(tol::Float64, order::Int)
    coeffs = zeros(Float64, order)
    ccall((:fourier_poly, libpswf), Cvoid, (Float64, Int, Ptr{Float64}), tol, order, coeffs)
    return coeffs
end