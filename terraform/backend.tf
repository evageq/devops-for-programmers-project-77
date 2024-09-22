terraform { 
  cloud { 
    
    organization = "egostev" 

    workspaces { 
      name = "hexlet" 
    } 
  } 
}
