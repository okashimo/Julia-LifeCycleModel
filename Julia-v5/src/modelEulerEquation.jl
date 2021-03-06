function getmargutility(params::Dict{String,Float64}, cons::Float64)
    margutils = cons^(-params["gamma"])
end

# NOTE: will need to pass in the parameters to this function
# (in matlab, cormac was using globals to pass around the parameter gamma. but globals are very slow, so the code is faster when we pass in the parameters)
function  getmargutility(cons)
   if cons<=0
                     error("Consumption is <=0")

   elseif gamma==1
                    margut=1./cons

   else
                    margut = (cons).^(-gamma)
   end
end

function getinversemargutility(margut)
    if gamma == 1
        invmargut = 1/margut;
    else
        invmargut = margut^(-1/gamma);
    end
end

function eulerforzero(params::Dict{String,Float64}, EdU1_at_A1, A0::Float64, A1::Float64, Y::Float64)
    #-------------------------------------------------------------------------------#
    #This function returns the following quantity:
    #u'(c_t) - b(1+r)u'(c_t+1)
    #This quantity =0 when the Euler equation u'(c_t) = b(1+r)u'(c_t+1)
    #is satified with equality

    #-------------------------------------------------------------------------------#
    # Get marginal utility of consumption tomorrow, given A1

    du1AtA1 = EdU1_at_A1[A1]

    ## ------------------------------------------------------------------------
    # Check whether tomorrow's (expected) marginal utility negative If so throw an error

    # TODO: why can this never be negative? is this just specific to CRRA?

    if (du1AtA1 < 0)
       error("approximated marginal utility in negative")
    end

    ## ------------------------------------------------------------------------
    # Get consumption today and the required output
    todaycons = A0 + Y - A1/(1+params["r"])
    euler = getmargutility(params, todaycons) - (params["beta"] * (1+params["r"]) * du1AtA1)

end
