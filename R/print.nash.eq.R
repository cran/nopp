print.nash.eq <-
function(x,...){
 
 digits <- 3
 dots <- list(...)
 idx <- which(names(dots)=="digits")
 if(length(idx)==1)
  digits = dots[[idx]]
 
 pos <- NULL
   if(!is.null(x$position))
    pos <- x$position

   idd <- which(names(dots) == "pos")
   if(length(idd)==1)
    pos <- dots[[idd]]

 #  print(str(pos)) 
   votes <- NULL
   if(!is.null(x$votes))
    votes <- x$votes
   ide <- which(names(dots) == "votes")
   if(length(ide)==1)
    votes <- dots[[ide]]
 #  print(str(votes)) 


 if(!is.null(pos) & !is.null(votes)){
  cat("\n\n================\nExternal\n================")
  if(!is.null(pos)){
   idx <- match( names(x$basic$est) , names(pos))
   tpos <- unlist(pos)[idx]
   cat("\nParty positions:\n")
   print(round(tpos,digits=digits))
  }
  if(!is.null(votes)){
   idx <- match( names(x$basic$mP) , names(votes))
   tvotes <- unlist(votes)[idx]
   cat("\nParty vote-shares:\n")
   print(round(tvotes,digits=digits))
  }
 }
 
 cat("\n\n================\nNash equilibrium\n================")
 
 cat("\nParty positions:\n")
 print(round(x$basic$est,digits=digits))
 if(!is.null(pos)){
     emn <- x$basic$est
     idx <- match( names(emn) , names(pos))
     tpos <- unlist(pos)[idx]
     mm <- rbind(emn, tpos)
     avg <- mean(abs(mm[1,]-mm[2,]))
     cat(sprintf("\nCorrelation External/Nash: %.2f\nAverage Absolute Distance: %.2f\n", cor(emn, tpos), avg))

 }

 cat("\nParty vote-shares:\n")
 print(round(x$basic$mP,digits=digits))
    if(!is.null(votes)){
     mP <- x$basic$mP
     idx <- match( names(mP) , names(votes))
     tvotes <- unlist(votes)[idx]
     mm <- rbind(mP, tvotes)*100
     avg <- mean(abs(mm[1,]-mm[2,]))
     cat(sprintf("\nCorrelation External/Nash: %.2f\nAverage Absolute Distance: %.2f%%\n", cor(mP, tvotes), avg))
     }
 


  
     
 if(!is.null(x$MC)){
  cat("\n================\nMonte Carlo\n================")
  cat("\nParty positions:\n")
  tmp <- as.table(rbind(x$MC$est.LB, x$MC$est.mean, x$MC$est.UB))
  colnames(tmp) <- names(x$MC$est.mean)
  rownames(tmp) <- c(
    sprintf("%.1f%% lower bound", 100*(1-x$MC$conf.level)/2),
    "mean estimate",
    sprintf("%.1f%% upper bound", 100*(1-(1-x$MC$conf.level)/2))
  )



  print(round(tmp,digits=digits))

  if(!is.null(pos)){
     emn <- x$MC$est.mean
     idx <- match( names(emn) , names(pos))
     tpos <- unlist(pos)[idx]
     mm <- rbind(emn, tpos)
     avg <- mean(abs(mm[1,]-mm[2,]))
     cat(sprintf("\nCorrelation External/Nash: %.2f\nAverage Absolute Distance: %.2f\n", cor(emn, tpos), avg))

  }


  cat("\nParty vote-shares:\n")
  tmp <- as.table(rbind(x$MC$mP.LB, x$MC$mP.mean, x$MC$mP.UB))
  colnames(tmp) <- names(x$MC$mP.mean)
  rownames(tmp) <- c(
    sprintf("%.1f%% lower bound", 100*(1-x$MC$conf.level)/2),
    "mean estimate",
    sprintf("%.1f%% upper bound", 100*(1-(1-x$MC$conf.level)/2))
  )

  print(round(tmp,digits=digits))
 
  if(!is.null(votes)){
     mP <- x$MC$mP.mean
     idx <- match( names(mP) , names(votes))
     tvotes <- unlist(votes)[idx]
     mm <- rbind(mP, tvotes)*100
     avg <- mean(abs(mm[1,]-mm[2,]))
     cat(sprintf("\nCorrelation External/Monte Carlo: %.2f\nAverage Absolute Distance: %.2f%%\n", cor(mP, tvotes), avg))
     }

  cat(sprintf("\nMonte Carlo replications: %d\n", x$boot$replications))
 }    
 
 
 
 

 if(!is.null(x$boot)){
  cat("\n================\nBootstrap\n================")
  cat("\nParty positions:\n")
  tmp <- as.table(rbind(x$boot$est.LB, x$boot$est.mean, x$boot$est.UB))
  colnames(tmp) <- names(x$boot$est.mean)
  rownames(tmp) <- c(
    sprintf("%.1f%% lower bound", 100*(1-x$boot$conf.level)/2),
    "mean estimate",
    sprintf("%.1f%% upper bound", 100*(1-(1-x$boot$conf.level)/2))
   )
  print(round(tmp,digits=digits))
  if(!is.null(pos)){
     emn <- x$boot$est.mean
     idx <- match( names(emn) , names(pos))
     tpos <- unlist(pos)[idx]
     mm <- rbind(emn, tpos)
     avg <- mean(abs(mm[1,]-mm[2,]))
     cat(sprintf("\nCorrelation External/Bootstrap: %.2f\nAverage Absolute Distance: %.2f\n", cor(emn, tpos), avg))

  }


  cat("\nParty vote-shares:\n")
  tmp <- as.table(rbind(x$boot$mP.LB, x$boot$mP.mean, x$boot$mP.UB))
  colnames(tmp) <- names(x$boot$mP.mean)
  rownames(tmp) <- c(
    sprintf("%.1f%% lower bound", 100*(1-x$boot$conf.level)/2),
    "mean estimate",
    sprintf("%.1f%% upper bound", 100*(1-(1-x$boot$conf.level)/2))
  )
  print(round(tmp,digits=digits))
  
    if(!is.null(votes)){
     mP <- x$boot$mP.mean
     idx <- match( names(mP) , names(votes))
     tvotes <- unlist(votes)[idx]
     mm <- rbind(mP, tvotes)*100
     avg <- mean(abs(mm[1,]-mm[2,]))
     cat(sprintf("\nCorrelation External/Monte Carlo: %.2f\nAverage Absolute Distance: %.2f%%\n", cor(mP, tvotes), avg))
     }

  cat(sprintf("\nBootstrap replications: %d\n", x$boot$replications))
 } 
 
}
