function get_library_path()
    base_dir = joinpath(dirname(@__FILE__), "..", "build")
    
    if Sys.iswindows()
        lib_path = joinpath(base_dir, "PSWF.dll")
    elseif Sys.isapple()
        lib_path = joinpath(base_dir, "libPSWF.dylib")
    else
        lib_path = joinpath(base_dir, "libPSWF.so")
    end
    
    if !isfile(lib_path)
        error("Library file not found: $lib_path\nPlease build the project first using CMake.")
    end
    
    return lib_path
end

const libpswf = get_library_path()

function prolc180(eps::Float64)
    ccall((:prolc180, libpswf), Float64, (Float64,), eps)
end

function prolate0_lambda(c::Float64)
    ccall((:prolate0_lambda, libpswf), Float64, (Float64,), c)
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