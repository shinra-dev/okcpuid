# -------------------------------------------------
# Addition
# -------------------------------------------------

setMethod("+", signature(e1="flops", e2="flops"),
  function(e1, e2) 
  {
    # if names disagree, use .NAMES
    if (e1@unit.names != e2@unit.names){
      if (e1@unit.names != .NAMES)
        e1 <- swap.names(e1)
    }
    
    e1 <- convert_to_flops(e1)
    e2 <- convert_to_flops(e2)
    
    e1@size <- e1@size + e2@size
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)


setMethod("+", signature(e1="flops", e2="numeric"),
  function(e1, e2) 
  {
    if (length(e2) != 1)
      stop("flops + numeric : vector must be of length 1")
    
    e1 <- convert_to_flops(e1)
    
    e1@size <- e1@size + e2
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)


setMethod("+", signature(e1="numeric", e2="flops"),
  function(e1, e2)
  {
    if (length(e1) != 1)
      stop("numeric + flops : vector must be of length 1")
    else
      return( e2+e1 )
  }
)



setMethod("+", signature(e1="object_size", e2="flops"),
  function(e1, e2)
    return( e2+e1 )
)



# -------------------------------------------------
# Subtraction
# -------------------------------------------------

setMethod("-", signature(e1="flops", e2="flops"),
  function(e1, e2)
    return( e1+(-1*e2) )
)



setMethod("-", signature(e1="flops", e2="numeric"),
  function(e1, e2)
  {
    if (length(e2) != 1)
      stop("flops - numeric : vector must be of length 1")
    else
      return( e1+(-1*e2) )
  }
)



setMethod("-", signature(e1="numeric", e2="flops"),
  function(e1, e2)
  {
    if (length(e1) != 1)
      stop("vector - numeric : vector must be of length 1")
    else
      return( e1+(-1*e2) )
  }
)



setMethod("-", signature(e1="flops", e2="missing"),
  function(e1, e2)
    return( -1*e1 )
)



# -------------------------------------------------
# Multiplication
# -------------------------------------------------

setMethod("*", signature(e1="flops", e2="flops"),
  function(e1, e2) 
  {
    # if names disagree, use .NAMES
    if (e1@unit.names != e2@unit.names){
      if (e1@unit.names != .NAMES)
        e1 <- swap.names(e1)
    }
    
    e1 <- convert_to_flops(e1)
    e2 <- convert_to_flops(e2)
    
    e1@size <- e1@size * e2@size
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)



setMethod("*", signature(e1="flops", e2="numeric"),
  function(e1, e2) 
  {
#    if (length(e2) != 1)
#      stop("flops * numeric : vector must be of length 1")
    
    e1 <- convert_to_flops(e1)
    
    e1@size <- e1@size * e2
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)



setMethod("*", signature(e1="numeric", e2="flops"),
  function(e1, e2)
  {
    if (length(e1) != 1)
      stop("numeric * flops : vector must be of length 1")
    else
      return( e2*e1 )
  }
)



# -------------------------------------------------
# Division
# -------------------------------------------------

setMethod("/", signature(e1="flops", e2="flops"),
  function(e1, e2) 
  {
    # if names disagree, use .NAMES
    if (e1@unit.names != e2@unit.names){
      if (e1@unit.names != .NAMES)
        e1 <- swap.names(e1)
    }
    
    e1 <- convert_to_flops(e1)
    e2 <- convert_to_flops(e2)
    
    e1@size <- e1@size / e2@size
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)



setMethod("/", signature(e1="flops", e2="numeric"),
  function(e1, e2) 
  {
    if (length(e2) != 1)
      stop("flops * numeric : vector must be of length 1")
    
    e1 <- convert_to_flops(e1)
    
    e1@size <- e1@size / e2
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)



setMethod("/", signature(e1="numeric", e2="flops"),
  function(e1, e2)
  {
    if (length(e1) != 1)
      stop("vector * numeric : vector must be of length 1")
    else
      return( e2/e1 )
  }
)



# -------------------------------------------------
# Exponentiation
# -------------------------------------------------

setMethod("^", signature(e1="flops", e2="flops"),
  function(e1, e2) 
  {
    # if names disagree, use .NAMES
    if (e1@unit.names != e2@unit.names){
      if (e1@unit.names != .NAMES)
        e1 <- swap.names(e1)
    }
    
    e1 <- convert_to_flops(e1)
    e2 <- convert_to_flops(e2)
    
    e1@size <- e1@size ^ e2@size
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)



setMethod("^", signature(e1="flops", e2="numeric"),
  function(e1, e2) 
  {
    if (length(e2) != 1)
      stop("flops ^ vector : vector must be of length 1")
    
    e1 <- convert_to_flops(e1)
    
    e1@size <- e1@size ^ e2
    
    ret <- swap.unit(e1, .UNIT)
    
    return( ret )
  }
)


