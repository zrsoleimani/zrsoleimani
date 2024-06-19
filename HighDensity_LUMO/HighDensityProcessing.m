%% Processing Pipeline for High Density fNIRS

%  input file: .lufr

%  This will be using lumomat toolbox, DOTHUB_Toolbox, TOAST++, and Homer2. 
%  Make sure paths are set for all these toolboxes/packages.

%% Section 1.0 Importing data and Preprocessing - Converting LUFR to NIRS format

% Script to run preprocessing for Exploration LUMO
% need script "########"

% Written By: Chloe Britton Naime 03 June 2024 in MATLAB 2024a
% Edited By:
% Ran By: 

% Cleaning environment and adding paths 
  clear all;
  clc
  
  addpath(genpath('/Users/bll/Desktop/Testing_MATLab')) 

% Load Data
  filelist = dir('/Users/bll/Desktop/Testing_MATLab/Data/lufr_data/*.lufr')
  jsonlist = dir('/Users/bll/Desktop/Testing_MATLab/Data/Layouts/*.JSON')

% Create empty data array
  data = zeros(1, length(filelist));
  nirs = zeros(1, length(filelist));
  
% Converting from .lufr to .nirs
  for subInd = 1:length(filelist)
         filename = filelist(subInd).name
         data = LumoData(['/Users/bll/Desktop/Testing_MATLab/Data/lufr_data/',filelist(subInd).name])
         read = lumofile.read_lufr(['/Users/bll/Desktop/Testing_MATLab/Data/lufr_data/',filelist(subInd).name],'layout',[''])
         nirs = data.write_NIRS(['/Users/bll/Desktop/Testing_MATLab/Data/lufr_data/',filelist(subInd).name],'sd_style','flat')   
  end
  
%% Section 2.0 Data Quality Check (Attempt 1)

% Directory for nirs files to be pulled for Data Quality Check
  dqlist = dir('/Users/bll/Desktop/Testing_MATLab/Data/LUFR2NIRS/*.nirs')

% Data Quality Check

  for subInd = 1:length(dqlist)
         filename = dqlist(subInd).name
         DOTHUB_dataQualityCheck(['/Users/bll/Desktop/Testing_MATLab/Data/LUFR2NIRS/',dqlist(subInd).name])  
  end

%% Data Quality Check (Attempt 2) - Uses QTNIRS package

% Directory for nirs files to be pulled for Data Quality Check
  dqlist = dir('/Users/bll/Desktop/Testing_MATLab/Data/LUFR2NIRS/*.nirs')

% Data Quality Check

  for subInd = 1:length(dqlist)
         filename = dqlist(subInd).name
         qtnirs(['/Users/bll/Desktop/Testing_MATLab/Data/LUFR2NIRS/',dqlist(subInd).name])

  end

%%
qtnirs(['/Users/bll/Desktop/Testing_MATLab/Data/LUFR2NIRS/LEXPL005_2_30-03-23_14-43-46.nirs'])
%%
generateQReport(['/Users/bll/Desktop/Testing_MATLab/Data/LUFR2NIRS/LEXPL005_2_30-03-23_14-43-46.nirs'])
%% Section 3.0 Preprocessing  

%
  for subInd = 1:length(dqlist)
         filename = dqlist(subInd).name
         DOTHUB_runHomerPrepro(['/Users/bll/Desktop/Testing_MATLab/Data/LUFR2NIRS/',dqlist(subInd).name])  
  end
