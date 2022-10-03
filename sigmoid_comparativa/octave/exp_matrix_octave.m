MAXSIZE=1000000
REIT=500
XXX=-5


datestr(clock())

xv=zeros(MAXSIZE,REIT);
yv=zeros(MAXSIZE,REIT);



    p = XXX;

    for i = 1:MAXSIZE

      xv(i,1)=p;

      p += 0.00001;
      
    end
    for r = 2:REIT
      
      xv(:,r)=xv(:,1);
  
    end
 

datestr(clock())

      yv=exp(xv);
  
datestr(clock())