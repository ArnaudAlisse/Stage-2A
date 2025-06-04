using PowerModels
using PowerModelsACDC
using Ipopt
using JuMP
#Pkg.add("Juniper")
using Juniper
using HiGHS
using HiGHS_jll

#Need to add that because otherwise it's not detected (I have a lot of issues of this type, it's bothering me because I don't succeed in completely solving it)

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
calc_thermal_limits!(network_data) #Allow one to add the thermal limit on the network, may be useful no?


#result = solve_ac_opf(network_data, Ipopt.Optimizer) #useful to check where are the problems
result = solve_tnep(network_data, ACPPowerModel, minlp_solver) #solve_tnep call build_tnep, and here is the 1st step to have interesting results


#absolutely horrible, so many bugs, took that from a test file and it doens't work aaaaaaah

s = Dict("output" => Dict("branch_flows" => true), "conv_losses_mp" => true)
#resultDC = result = run_acdctnepopf(network_data, DCPPowerModel, highs ; setting = s)   #The solver used in the test is highs, Ipopt.Optimizer is also a possibilitie


#check_tnep_status(result["solution"])
#check_ne_branch_keys(result["solution"])



#I FEEL LIKE I DO NOT USE ALL THE POSSIBILITIES OF POWERMODEL, what I did is like 3 lines, how much more can we do?


# Afficher les résultats
println(result["termination_status"])
println(result["objective"])
#print_summary(result["solution"])

#To see which branch has been built : result["ne_branch"] and check which one has the "built" value at 1 or 0. 1 = built, 0 = not built.


