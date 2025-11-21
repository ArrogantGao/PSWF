using ProlateSpheroidal
using Test

@testset "ProlateSpheroidal.jl" begin
    for eps in 10.0 .^ (-15.0:1.0:-1.0)
        c = prolc180(eps)
        @test prolate0_eval(c, 1.0) < 2 * eps
    end
end
