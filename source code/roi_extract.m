function [im_DIF] = roi_extract(n_regions)
    %n_regions = 3;
    
    n_regions = getappdata(0,'n_regions');
    
    %--------------------------------------------------------------------------
                          %%% charge et lecture de l'image %%%
    %--------------------------------------------------------------------------                
    [filename, pathname] = uigetfile('*.bmp;*.jpg', 'open image');% only image Bitmap
    if isequal(filename, 0) || isequal(pathname, 0)   
        disp('Image input canceled.');  
       X = [];    map = []; 
    else
        [X,MAP]=imread(fullfile(pathname, filename));%Lecture d'image.
    end;
    lsz=length(size(X));
    if lsz==3
    %X=rgb2gray(X);
    end
    %---------------------------------------------------------------------------------------------------
     %%%Region of interest extraction ( Extraction d'une région d'intéret à main libre )by free hand %%%
    %---------------------------------------------------------------------------------------------------
    im0=X;
    X=double(X);
    
    %helpdlg('Choose ROI from the figure','Point Selection');
    
    %preallocation not done yet
    sz = size(X);
    ROI = zeros( [sz, n_regions] );
    im_DIF = zeros( [sz, n_regions] );
 
    hFig = 1;
    for r = 1:n_regions
    
        if ishandle(hFig)==0
            hFig = figure;
        end
        h_im = imshow(im0),title('Choose ROI from the figure and double click when finalized');
        h = imfreehand;
        position = wait(h);
        %h = imfreehand;
        %position2 = wait(h);
        %fprintf( 'Hello, %f worlds!', position2 );

        e = impoly(gca,position);
        BW = createMask(e,h_im);

        %Extracting ROI from each band

        
        n = sz(3);
        %ROI(:,:,:,r) = zeros(sz);
        for i = 1:n
            ROI(:,:,i,r) = X(:,:,i).*BW;
        end

        im_DIF(:,:,:,r)=X-ROI(:,:,:,r);
        X=X-ROI(:,:,:,r);

        %a = uint8(ROI(:,:,:,r)); 
        %b = uint8(im_DIF(:,:,:,r));

        %figure,imshow(a);
        %figure,imshow(b);
    end
    %imwrite(ROI,'C:\Users\admin\Downloads\ASIP\rs_data\Region_of_interest.bmp','bmp');
    %imwrite(im_DIF,'C:\Users\admin\Downloads\ASIP\rs_data\Image_difference.bmp','bmp');

    %Now write data to text file
    %yo = [0];
    
    for r = 1:n_regions
        fileID = fopen(strcat('', 'train', num2str(r), '.txt'),'w');
        %fprintf(fileID,'%6s %12s\n','x','exp(x)');
        flag = 0;
        %Write true positives
        for i = 1:sz(1)
            for j = 1:sz(2)
                for band = 1:sz(3)
                    if ROI(i,j,band,r) > 0.0
                        flag = 1;
                        break;
                    end
                end
                %Write ProperData
                if flag == 1
                    for band = 1:sz(3)
                        fprintf(fileID,'%1.1f,', ROI(i,j,band,r));
                    end
                    fprintf(fileID,'%s\r\n', 'Iris-setosa');
                    flag = 0;
                end
            end
        end
        
        %Write true negatives
        for r_temp = 1:n_regions;
            if r == r_temp
                continue;
            end
            for i = 1:sz(1)
                for j = 1:sz(2)
                    for band = 1:sz(3)
                        if ROI(i,j,band,r_temp) > 0.0
                            flag = 1;
                            break;
                        end
                    end
                    %Write ProperData
                    if flag == 1
                        for band = 1:sz(3)
                            fprintf(fileID,'%1.1f,', ROI(i,j,band,r_temp));
                        end  
                        fprintf(fileID,'%s\r\n', 'Iris-versicolor');
                        flag = 0;
                    end
                end
            end
        end
        
        fclose(fileID);
    end
    
    %Write test data to output
%     fileID_test = fopen(strcat('C:\Users\admin\Downloads\ASIP\rs_data\', 'test.txt'),'w');
%     b = uint8(im_DIF(:,:,:,r));
%     imshow(b);
%     for i = 1:sz(1)
%         for j = 1:sz(2)
%             for band =1:sz(3)
%                 if im_DIF(i,j,band,r_temp) > 0.0
%                     flag = 1;
%                     break;
%                 end
%             end
%             %Write ProperData
%             if flag == 1
%                 for band = 1:sz(3)
%                    fprintf(fileID_test,'%1.1f,', im_DIF(i,j,band,r_temp));
%                 end  
%                 fprintf(fileID_test,'%s\r\n', 'Iris-versicolor');
%                 flag = 0;
%             end
%         end
%     end
% 
%     fclose(fileID_test);
    h=msgbox('Region Extraction Completed. The perceptrons can now be trained','Success');
end