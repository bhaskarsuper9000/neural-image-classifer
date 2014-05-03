%GUI main function 
n_regions = 3;

im_DIF = roi_extract(n_regions);

W = train(n_regions);

classify(W, n_regions, im_DIF);