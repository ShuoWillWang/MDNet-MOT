%% DEMO_TRACKING
%
% Running the MDNet tracker on a given sequence.
%
% Hyeonseob Nam, 2015
%

clear;

address = ['train/MOT16-04';'train/MOT16-02'];

for i = 1:size(address,1)
    conf = genConfig('mot',['MOT16/' address(i,:)]);%'train/MOT16-02'
% conf = genConfig('vot2015','ball1');

    switch(conf.dataset)
        case 'otb'
            net = fullfile('models','mdnet_vot-otb.mat');
        case 'vot2014'
            net = fullfile('models','mdnet_otb-vot14.mat');
        case 'vot2015'
            net = fullfile('models','mdnet_otb-vot15.mat');
        case 'mot'
            net = fullfile('models','mdnet_vot-otb.mat');
    end
    %% define the initialization for multiple targets. 2 as an example here
    % conf.gt = [948,153,154,624; 868,256,84,294];
    %%; 868,256,84,294
    pathSave = [conf.imgDir(1:end-4) 'trackingM_withDet/'];
    detPath = fullfile(conf.imgDir(1:end-4),'det/det.txt');
    det = importdata(detPath);
    %visualizeDet(conf.imgList, 1, pathSave, det);
    result = mdnet_run(conf.imgList, net, 1, pathSave, det);
    %result = mdnet_run_ori(conf.imgList, conf.gt, net, 1);
end