MAXSIZE=1000000
REIT=500
XXX=-5


datestr(clock())

xv=zeros(MAXSIZE,REIT,'single');
yv=zeros(MAXSIZE,REIT,'single');



    p = XXX;

    for i = 1:MAXSIZE

      xv(i,1)=p;

      p += 0.00001;
      
    end
    for r = 2:REIT
      
      xv(:,r)=xv(:,1);
  
    end
 

datestr(clock())
    for i = 1:20
      yv=exp(xv);
    end
datestr(clock())

datestr(clock())
    for i = 1:20
      for r = 1:REIT

      yv(:,r)=exp(xv(:,r));
    
      end
    end
datestr(clock())