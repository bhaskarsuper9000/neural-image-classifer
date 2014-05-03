function [] = classify(W, n_regions, im_DIF)

     n_regions = getappdata(0,'n_regions');
     W= getappdata(0,'W');
     im_DIF = getappdata(0,'im_DIF');
      
    op = get_output(W,'test.txt',',', n_regions, im_DIF);
    figure, imshow( uint8(op) ),title(strcat('Classified Image contains  ',num2str(n_regions),'  classes'))
end