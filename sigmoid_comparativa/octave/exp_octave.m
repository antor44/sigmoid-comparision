MAXSIZE=1000000
REIT=10 # tarda mucho
XXX=-5


datestr(clock())

xv=zeros(MAXSIZE,1);
yv=zeros(MAXSIZE,1);


  for r = 0:REIT
    p = XXX;

    for i = 1:MAXSIZE

      xv(i)=p;
      yv(i)=exp(p);

      p += 0.00001;
    end
    
  end

datestr(clock())

 