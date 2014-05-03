function [color] = region_color(o, n_regions, color_array)
    %color_array = zeros(3,10);
    
    count = 0;
    index = 0;
    bands=size(o);
    
    classes=zeros(1,n_regions);
    
     for i=1:n_regions
         for j=1:bands(2)
             classes(i)=classes(i)+o(i,j);
         end
         classes(i)=classes(i) + o(i,j);
     end

    
   % x = o(1,1)+o(1,2)+o(1,3)+o(1,4);
   % y = o(2,2)+o(2,2)+o(2,3)+o(2,4);
   % z = o(3,3)+o(3,2)+o(3,3)+o(3,4); 

    %fprintf('%d %d %d %d\n',x, y, z, max([x y z]));  
    %disp(x)
    %disp(y)
    %disp(z)
    %disp( max([x y z]) )
    
    index=0;
    minimum=min(classes);
    
    for i=1:n_regions
        if(classes(i)==minimum)
            index=i;
        end
    end
    
    color=color_array(:,index);
    
%     switch min( [x y z] )
%     case x
% %         s = size(color_array);
% %         sz = mod(1, s(2));
% %         z = sz(1);
%         color = [200 110 50];%color_array( :, z );
%     case y
% %         s = size(color_array);
% %         sz = mod(2, s(2));
% %         z = sz(1);
%         color = [20 40 255];%color_array( :, z );
%     case z
% %         s = size(color_array);
% %         sz = mod(3, s(2));
% %         z = sz(1);
%         color = [200 10 65];%color_array( :, z );
%     otherwise
%         color = [100 100 100];
%     end
    
 end