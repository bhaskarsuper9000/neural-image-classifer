function [op] = get_output(W,data,delimiter,n_regions,im_DIF)
    
    color_array = zeros(3,n_regions+1);
    for i = 1:n_regions+1
        color_array(:,i) = [randi(255) randi(255) randi(255)];
    end

    %if(class(data) == 'char')
    %    [data file_format col_num] = read_format_data(data,delimiter);
    %end

    hFig = 2;
    %Write test data to output
    %fileID_test = fopen(strcat('C:\Users\admin\Downloads\ASIP\rs_data\', 'test.txt'),'w');
    b = uint8(im_DIF(:,:,:,n_regions));
    if ishandle(hFig)==0
        hFig = figure;
    end
    imshow(b);
    
    sz = size(im_DIF(:,:,:,1));
    op = zeros(sz);
    zandu = size(im_DIF);
    
    r_temp = zandu(4);
    t_DIF = zeros(1,sz(3)+1);
    for i = 1:sz(1)
        for j = 1:sz(2)
            for band =1:sz(3)
                if im_DIF(i,j,band,r_temp) > 0.0
                    flag = 1;
                    break;
                end
            end
            %Write ProperData
            if flag == 1
                %for band = 1:sz(3)
                    %fprintf(fileID_test,'%1.1f,', im_DIF(i,j,band,r_temp));
                o = zeros(n_regions, sz(3)+1);
                for r = 1:n_regions
                    a = im_DIF(i,j,:,r);
                    t_DIF = [a(:)' -1];
                    %t_DIF = 
                    o(r,:) = predict_class_raw(t_DIF,W(:,r));    
                end
                op(i,j,:) = region_color(o, n_regions, color_array);
                %end  
                %fprintf(fileID_test,'%s\r\n', 'Iris-versicolor');
                flag = 0;
            end
        end
    end
end