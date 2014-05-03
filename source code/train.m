
function [W] = train(n_regions)
n_regions = getappdata(0,'n_regions');
    W = zeros(4,n_regions);

    for r = 1:n_regions
        [data file_format col_num] = read_format_data(strcat('', 'train', num2str(r), '.txt'),',');    

        W(:,r) = perceptron(data,',',0.1);
    end

    h=msgbox('Training Completed','Success');
end

