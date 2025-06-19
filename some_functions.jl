function Is_there_already_an_AC_branc(f,t,network_data)

    for i in keys(network_data["branch"])
        if network_data["branch"]["$i"]["f_bus"] == f && network_data["branch"]["$i"]["t_bus"] == t
            println("The AC branch connecting the buses $f and $t cannot be build because of there is already an AC branch connecting these buses")
            return true
        elseif network_data["branch"]["$i"]["f_bus"] == t && network_data["branch"]["$i"]["t_bus"] == f #Because of the bidirectionnality of the branches
            println("The AC branch connecting the buses $f and $t cannot be build because of there is already an AC branch connecting these buses")
            return true
        else
            continue
        end
    end
    return false
end

function Is_there_already_a_DC_branc(f,t,network_data)

    for i in keys(network_data["branchdc"]) #going through every dc branch
        if network_data["branchdc"]["$i"]["fbusdc"] == f && network_data["branchdc"]["$i"]["tbusdc"] == t
            println("The DC branch connecting the buses $f and $t cannot be build because of there is already a DC branch connecting these buses")
            return true
        elseif network_data["branchdc"]["$i"]["fbusdc"] == t && network_data["branchdc"]["$i"]["tbusdc"] == f
            println("The DC branch connecting the buses $f and $t cannot be build because of there is already a DC branch connecting these buses")
            return true
        else 
            continue
        end
    end
    return false
end

function build_new_AC_branch(f,t,network_data,b,k)
    println("The AC branch connecting the bus $f and the bus $t has been build")
    a=length(network_data["branch"])+b #The b is needed to not give an already given ID to the new branch.
    network_data["branch"]["$a"] = copy(network_data["ne_branch"]["$k"])
    network_data["branch"]["$a"]["rate_b"] = network_data["branch"]["$a"]["rate_a"] #We copy the rate_a for each rate. In fact, PowerModels only use the rate_a so it doens't really matter
    network_data["branch"]["$a"]["rate_c"] = network_data["branch"]["$a"]["rate_a"]  
    network_data["branch"]["$a"]["source_id"] = Any["branch", a] 
    network_data["branch"]["$a"]["index"] = a
    delete!(network_data["branch"]["$a"],"construction_cost")
            #We added all the terms needed to the good functionnement of "solve_opf"
            #And removed "construction_cost" that wasn't needed.
end



function build_new_DC_branch(f,t,network_data,b,k)
    println("The DC branch connecting the bus $f and the bus $t has been build")
    a=length(network_data["branchdc"])+b
    network_data["branchdc"]["$a"] = copy(network_data["branchdc_ne"]["$k"])
    network_data["branchdc"]["$a"]["source_id"] = [(2)]  
    network_data["branchdc"]["$a"]["index"] = a
    delete!(network_data["branchdc"]["$a"],"cost")
end



function build_new_convDC(network_data,b,k)
    AC = network_data["convdc_ne"]["$k"]["busac_i"]
    DC = network_data["convdc_ne"]["$k"]["busdc_i"]
    println("The DC converter connecting the AC bus $AC and the DC bus $DC has been build")
    a=length(network_data["convdc"])+b
    network_data["convdc"]["$a"] = network_data["convdc_ne"]["$k"]
    delete!(network_data["convdc"]["$a"],"cost")
end

function build_new_busDC(network_data,b,k)
    DC = network_data["convdc_ne"]["$k"]["busdc_i"]
    println("The DC bus $DC has been build")
    a=length(network_data["busdc"])+b
    network_data["busdc"]["$a"] = network_data["busdc_ne"]["$k"]
    network_data["busdc"]["$a"] = Any["busdc", a]
end


function uptdate_network(network_data,result)

    global b=1
    for k in keys(network_data["ne_branch"])
    #looking through each possible branch if one must be build or not. We do not want two branch linking the same buses.
       if result["solution"]["ne_branch"]["$k"]["built"] ==1
            f = network_data["ne_branch"]["$k"]["f_bus"]
            t = network_data["ne_branch"]["$k"]["t_bus"]
            if Is_there_already_an_AC_branc(f,t,network_data) == false
                build_new_AC_branch(f,t,network_data,b,k)
                global b=b+1
            end
       end
    end

    global b=1
    for k in keys(network_data["branchdc_ne"])
        if result["solution"]["branchdc_ne"]["$k"]["isbuilt"]== 1
            f = network_data["branchdc_ne"]["$k"]["fbusdc"]
            t = network_data["branchdc_ne"]["$k"]["tbusdc"]       
            if Is_there_already_a_DC_branc(f,t,network_data) == false
                build_new_DC_branch(f,t,network_data,b,k)
                global b=b+1
            end
        end
    end

    global b=1
    for k in keys(network_data["convdc_ne"]) 
        if result["solution"]["convdc_ne"]["$k"]["isbuilt"] == 1
            build_new_convDC(network_data,b,k)
            global b = b+1
        end
    end

    #I didn't find any key related to busdc_ne in the result of the TNEP simulation, maybe no yet supported. So we comment that for the moment
    #global b=1          
    #for k in keys(network_data["busdc_ne"]) 
    #    if result["solution"]["busdc_ne"]["$k"]["isbuilt"] == 1
    #        build_new_busDC(network_data,b,k)
    #        global b = b+1
    #    end
    #end

end


function count_new_lines(network_data, result)
    b=0
    for k in keys(network_data["ne_branch"])
    #looking through each possible branch if one must be build or not. We do not want two branch linking the same buses.
       if result["solution"]["ne_branch"]["$k"]["built"] ==1
            f = network_data["ne_branch"]["$k"]["f_bus"]
            t = network_data["ne_branch"]["$k"]["t_bus"]
            if Is_there_already_an_AC_branc(f,t,network_data) == false
                b=b+1
            end
       end
    end

    for k in keys(network_data["branchdc_ne"])
        if result["solution"]["branchdc_ne"]["$k"]["isbuilt"]== 1
            f = network_data["branchdc_ne"]["$k"]["fbusdc"]
            t = network_data["branchdc_ne"]["$k"]["tbusdc"]       
            if Is_there_already_a_DC_branc(f,t,network_data) == false
                b=b+1
            end
        end
    end
    println("$b new branches will be build")
    return b
end


#function max_power_line(resultOPF)
#    for k in keys(resultOPF)
#    end
#end
