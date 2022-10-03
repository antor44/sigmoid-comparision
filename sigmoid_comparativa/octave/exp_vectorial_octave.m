MAXSIZE=1000000
REIT=500
XXX=-5


datestr(clock())

xv=zeros(MAXSIZE,1);
yv=zeros(MAXSIZE,1);


  for r = 0:REIT
    p = XXX;

    for i = 1:MAXSIZE

      xv(i)=p;

      p += 0.00001;
      
    end
    
  end
 

datestr(clock())

  for r = 0:REIT

      yv=exp(xv);
    
  end
  
datestr(clock())