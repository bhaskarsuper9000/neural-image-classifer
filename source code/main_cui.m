%Set number of regions
n_regions = 3;
im_DIF = roi_extract(n_regions);

%Initialize Perceptron weights
W = zeros(4,n_regions);
%% Training

for r = 1:n_regions
    [data file_format col_num] = read_format_data(strcat('C:\Users\admin\Downloads\ASIP\rs_data\', 'train', num2str(r), '.txt'),',');    

    W(:,r) = perceptron(data,',',0.1);
end

%% Testing


%[data file_format col_num] = read_format_data('C:\Users\admin\Downloads\ASIP\rs_data\test.txt',',');
%    x = [data(:,1:size(data,2)-1) (ones(size(data,1),1)*-1)];   %feature matrix + threshold value
%    x2 = x(:,1:end-1);              %for visualization
%    y = data(:,size(data,2));       %class matrix

op = get_output(W,'C:\Users\admin\Downloads\ASIP\rs_data\test.txt',',', n_regions, im_DIF);
figure, imshow( uint8(op) );