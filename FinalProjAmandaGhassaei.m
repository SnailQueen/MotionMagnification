addpath('./data');
addpath('./matlabPyrTools');
addpath('./matlabPyrTools/MEX');

dataDir = './data';
resultsDir = 'results';
mkdir(resultsDir);

verbose = false;% verbose logging
colorspaceForProcessing = 'ntsc';%ntsc, hsv, rgb

% all video files or directories of image sequences to process
% be sure to put a backslash in front of directory names for proper sorting
allFilesToProcess = cellstr(char('/bookshelf'));%, 'babyShort.mp4'));

for i=1:size(allFilesToProcess, 1)
    
    filename = allFilesToProcess(i);
    filename = filename{1};% get string out
    [frames, frameRate] = extractImgs(dataDir, filename, verbose);
    
    frames = preProcessFrames(frames, filename, colorspaceForProcessing, verbose);
    %10, 16, 0.4, 0.05, 0.1
	frames = eularianLinearMagnification(filename, frames, 0.4, 0.05, 10, 16);
    frames = postProcessFrames(frames, filename, colorspaceForProcessing, 0.1, verbose);
    
    writeVideoFromFrames(fullfile(resultsDir, filename), frameRate, frames, verbose);
end






