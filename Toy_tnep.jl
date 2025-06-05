using PowerModels
using PowerModelsACDC
using Ipopt
using JuMP
#Pkg.add("Juniper")
using Juniper
using HiGHS
using HiGHS_jll


minlp_solver = JuMP.optimizer_with_attributes(
    Juniper.Optimizer,
    "nl_solver"=>JuMP.optimizer_with_attributes(
        Ipopt.Optimizer,
        "tol"=>1e-4,
        "print_level"=>0,
    ),
    "log_levels"=>[],
)

network_data = PowerModels.parse_file("C:\\Users\\33781\\OneDrive\\Documents\\STAGE 2A\\toy.m")
calc_thermal_limits!(network_data)


#result = solve_ac_opf(network_data, Ipopt.Optimizer)
result = solve_tnep(network_data, ACPPowerModel, minlp_solver) #solve_tnep call build_tnep
# Afficher les résultats
println(result["termination_status"])
println(result["objective"])
#print_summary(result["solution"])
#To see which branch has been built : result["solution]["ne_branch"] and check which one has the "built" value at 1 or 0. 1 = built, 0 = not built.


s = Dict("output" => Dict("branch_flows" => true), "conv_losses_mp" => true)
resultDC = run_tnepopf("C:\\Users\\33781\\OneDrive\\Documents\\STAGE 2A\\toy.m"  , DCPPowerModel, minlp_solverres; setting = s) %Again and again it's so useful to look into the test of the source code

#check_tnep_status(result["solution"])
#check_ne_branch_keys(result["solution"])



#I FEEL LIKE I DO NOT USE ALL THE POSSIBILITIES OF POWERMODEL, what I did is like 3 lines, how much more can we do?





