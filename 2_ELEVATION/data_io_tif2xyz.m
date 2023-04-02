function status=data_io_tif2xyz(tiffil, ascfil, varargin)

OPT.polfil='';
OPT.nskip=1;
OPT.epsgin=4326;
OPT.epsgout=4326;
OPT=setproperty(OPT,varargin{:});

status=1;
% try
    I=geotiff_read(tiffil);
    data=double(I.z);
    data = data(1:OPT.nskip:end,1:OPT.nskip:end);
    
    x=(cumsum(ones(size(data)).*OPT.nskip.*I.info.map_info.dx,2)-OPT.nskip*I.info.map_info.dx)+I.info.map_info.mapx;
    y=(cumsum(ones(size(data)).*OPT.nskip.*(-I.info.map_info.dy),1)+OPT.nskip.*I.info.map_info.dy)+I.info.map_info.mapy;
    
    data(data<-1e+100)=NaN;
    data(isinf(data))=NaN;
    
    if exist(OPT.polfil,'file')
        disp('Inpolygon start')
        pol=landboundary('read',OPT.polfil);
        i=inpoly2(x,y,pol(:,1),pol(:,2));
        array=[x(~isnan(data) & i) y(~isnan(data) & i) data(~isnan(data)& i)];
        
    else
        array=[x(~isnan(data)) y(~isnan(data)) data(~isnan(data))];
    end
    
    if OPT.epsgin~=OPT.epsgout
       [x,y]=convertCoordinates(array(:,1),array(:,2),'CS1.code',OPT.epsgin,'CS2.code',OPT.epsgout);
       array=[x y array(:,3)];
    end
    
    fid=fopen(ascfil,'w');
    if OPT.epsgout==4326
       arraystr=compose('%.7f %.7f %.4f',array);
    else
       arraystr=compose('%.1f %.1f %.4f',array); 
    end
    fprintf(fid,'%s\n',arraystr{:});
    fclose(fid);
    
% catch
%     status=0;
% end

end