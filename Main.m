function [pLeft pRight] = Main()
% Main, runs the application

% Test points
% FROM IMAGE (outside)
% pl1 = [541,185,1]';         pr1 = [649,174,1]';
% pl2 = [537,377,1]';         pr2 = [478,391,1]';
% pl3 = [782,520,1]';         pr3 = [470,577,1]';
% pl4 = [670,331,1]';         pr4 = [656,339,1]';
% pl5 = [638,94,1]';          pr5 = [617,62,1]';
% pl6 = [631,290,1]';         pr6 = [705,289,1]';
% pl7 = [383,405,1]';         pr7 = [317,415,1]';
% pl8 = [117,114,1]';         pr8 = [254,146,1]';

% FROM WEBCAM (desk)
% pl1 = [268,305,1]';         pr1 = [211,271,1]';
% pl2 = [503,215,1]';         pr2 = [437,284,1]';
% pl3 = [326,107,1]';         pr3 = [337,121,1]';
% pl4 = [170,78,1]';          pr4 = [203,37,1]';
% pl5 = [209,293,1]';         pr5 = [169,241,1]';
% pl6 = [585,337,1]';         pr6 = [488,441,1]';
% pl7 = [425,381,1]';         pr7 = [286,403,1]';
% pl8 = [516,459,1]';         pr8 = [348,518,1]';
% pl9 = [228,189,1]';         pr9 = [237,161,1]';
% pl10 = [671,178,1]';        pr10 = [628,324,1]';
% pl11 = [505,55,1]';         pr11 = [524,139,1]';
% pl12 = [669,221,1]';        pr12 = [643,372,1]';
% pl13 = [552,125,1]';        pr13 = [537,224,1]';
% pl14 = [632,275,1]';        pr14 = [526,397,1]';
% pl15 = [545,234,1]';        pr15 = [464,320,1]';
% pl16 = [589,254,1]';        pr16 = [496,356,1]';
% pl17 = [646,241,1]';        pr17 = [563,370,1]';
% pl18 = [661,206,1]';        pr18 = [598,347,1]';
% pl19 = [632,162,1]';        pr19 = [598,291,1]';
% pl20 = [590,144,1]';        pr20 = [567,256,1]';
% pl21 = [561,200,1]';        pr21 = [503,297,1]';
% pl22 = [604,217,1]';        pr22 = [533,329,1]';
% pl23 = [617,187,1]';        pr23 = [563,307,1]';
% pl24 = [579,172,1]';        pr24 = [535,278,1]';
% pl25 = [521,182,1]';        pr25 = [473,262,1]';
% pl26 = [537,154,1]';        pr26 = [504,244,1]';
% pl27 = [492,242,1]';        pr27 = [425,309,1]';
% pl28 = [533,259,1]';        pr28 = [453,341,1]';
% pl29 = [576,278,1]';        pr29 = [483,377,1]';
% pl30 = [615,299,1]';        pr30 = [513,415,1]';
% pl31 = [483,267,1]';        pr31 = [418,328,1]';
% pl32 = [520,283,1]';        pr32 = [444,359,1]';
% pl33 = [560,302,1]';        pr33 = [472,393,1]';
% pl34 = [599,320,1]';        pr34 = [499,429,1]';
% pl35 = [549,320,1]';        pr35 = [462,408,1]';

% FROM WEBCAM 2 (checker board)
% pl1 = [678,476,1]';        pr1 = [576,446,1]';
% pl2 = [671,406,1]';        pr2 = [571,382,1]';
% pl3 = [662,343,1]';        pr3 = [565,318,1]';
% pl4 = [655,283,1]';        pr4 = [559,259,1]';
% pl5 = [649,225,1]';        pr5 = [554,202,1]';
% pl6 = [644,169,1]';        pr6 = [549,148,1]';
% pl7 = [636,117,1]';        pr7 = [544,96,1]';
% pl8 = [611,475,1]';        pr8 = [511,448,1]';
% pl9 = [605,408,1]';        pr9 = [507,382,1]';
% pl10 = [598,343,1]';        pr10 = [502,320,1]';
% pl11 = [593,282,1]';        pr11 = [499,260,1]';
% pl12 = [588,224,1]';        pr12 = [495,202,1]';
% pl13 = [583,169,1]';        pr13 = [492,148,1]';
% pl14 = [578,116,1]';        pr14 = [487,95,1]';
% pl15 = [520,116,1]';        pr15 = [430,94,1]';
% pl16 = [462,114,1]';        pr16 = [373,94,1]';
% pl17 = [404,115,1]';        pr17 = [314,93,1]';
% pl18 = [344,114,1]';        pr18 = [255,92,1]';
% pl19 = [286,114,1]';        pr19 = [195,92,1]';
% pl20 = [227,113,1]';        pr20 = [135,90,1]';
% pl21 = [225,166,1]';        pr21 = [131,147,1]';
% pl22 = [220,222,1]';        pr22 = [127,201,1]';
% pl23 = [216,280,1]';        pr23 = [122,261,1]';
% pl24 = [210,341,1]';        pr24 = [117,323,1]';
% pl25 = [207,407,1]';        pr25 = [113,389,1]';
% pl26 = [202,475,1]';        pr26 = [108,457,1]';
% pl27 = [270,476,1]';        pr27 = [177,456,1]';
% pl28 = [339,475,1]';        pr28 = [246,464,1]';
% pl29 = [408,476,1]';        pr29 = [314,453,1]';
% pl30 = [475,476,1]';        pr30 = [380,450,1]';
% pl31 = [542,476,1]';        pr31 = [447,450,1]';
% pl32 = [522,168,1]';        pr32 = [432,147,1]';
% pl33 = [527,222,1]';        pr33 = [434,202,1]';
% pl34 = [528,283,1]';        pr34 = [436,261,1]';
% pl35 = [533,343,1]';        pr35 = [440,319,1]';
% pl36 = [536,408,1]';        pr36 = [444,383,1]';
% pl37 = [464,167,1]';        pr37 = [374,146,1]';
% pl38 = [465,223,1]';        pr38 = [374,200,1]';
% pl39 = [468,280,1]';        pr39 = [376,260,1]';
% pl40 = [469,342,1]';        pr40 = [377,321,1]';
% pl41 = [473,406,1]';        pr41 = [380,384,1]';
% pl42 = [403,167,1]';        pr42 = [314,146,1]';
% pl43 = [405,222,1]';        pr43 = [313,202,1]';
% pl44 = [406,281,1]';        pr44 = [313,262,1]';
% pl45 = [404,343,1]';        pr45 = [313,321,1]';
% pl46 = [406,406,1]';        pr46 = [313,385,1]';
% pl47 = [344,167,1]';        pr47 = [253,146,1]';
% pl48 = [342,222,1]';        pr48 = [253,202,1]';
% pl49 = [342,281,1]';        pr49 = [251,260,1]';
% pl50 = [341,342,1]';        pr50 = [248,321,1]';
% pl51 = [340,407,1]';        pr51 = [247,386,1]';
% pl52 = [283,167,1]';        pr52 = [192,145,1]';
% pl53 = [281,222,1]';        pr53 = [189,202,1]';
% pl54 = [278,280,1]';        pr54 = [185,261,1]';
% pl55 = [276,341,1]';        pr55 = [183,323,1]';
% pl56 = [273,407,1]';        pr56 = [180,387,1]';

% Rubik's cube
pl1 = [845,522,1]';        pr1 = [787,624,1]';
pl2 = [766,474,1]';        pr2 = [715,565,1]';
pl3 = [676,424,1]';        pr3 = [633,497,1]';
pl4 = [594,373,1]';        pr4 = [564,434,1]';
pl5 = [668,325,1]';        pr5 = [655,380,1]';
pl6 = [737,366,1]';        pr6 = [716,431,1]';
pl7 = [820,416,1]';        pr7 = [791,495,1]';
pl8 = [911,469,1]';        pr8 = [874,563,1]';
pl9 = [722,287,1]';        pr9 = [725,335,1]';
pl10 = [791,326,1]';        pr10 = [787,384,1]';
pl11 = [878,371,1]';        pr11 = [862,445,1]';
pl12 = [969,423,1]';        pr12 = [952,510,1]';
pl13 = [1018,376,1]';        pr13 = [1020,457,1]';
pl14 = [931,331,1]';        pr14 = [938,394,1]';
pl15 = [861,290,1]';        pr15 = [869,345,1]';
pl16 = [784,250,1]';        pr16 = [799,293,1]';
pl17 = [591,455,1]';        pr17 = [572,510,1]';
pl18 = [658,495,1]';        pr18 = [627,557,1]';
pl19 = [738,549,1]';        pr19 = [699,624,1]';
pl20 = [827,602,1]';        pr20 = [777,694,1]';
pl21 = [590,530,1]';        pr21 = [583,576,1]';
pl22 = [653,570,1]';        pr22 = [633,623,1]';
pl23 = [731,621,1]';        pr23 = [700,687,1]';
pl24 = [817,673,1]';        pr24 = [778,756,1]';
pl25 = [590,595,1]';        pr25 = [592,633,1]';
pl26 = [652,635,1]';        pr26 = [640,678,1]';
pl27 = [723,684,1]';        pr27 = [703,743,1]';
pl28 = [803,740,1]';        pr28 = [777,813,1]';
pl29 = [865,682,1]';        pr29 = [850,754,1]';
pl30 = [875,632,1]';        pr30 = [855,704,1]';
pl31 = [891,562,1]';        pr31 = [862,650,1]';
pl32 = [921,624,1]';        pr32 = [921,694,1]';
pl33 = [930,576,1]';        pr33 = [926,652,1]';
pl34 = [948,508,1]';        pr34 = [939,588,1]';
pl35 = [961,586,1]';        pr35 = [978,650,1]';
pl36 = [976,529,1]';        pr36 = [991,596,1]';
pl37 = [997,461,1]';        pr37 = [1007,535,1]';

% PHASE 1 - Get Fundamental Matrix
% Put into matrix
%pLeft = [pl1,pl2,pl3,pl4,pl5,pl6,pl7,pl8,pl9,pl10,pl11,pl12,pl13,pl14,pl15,pl16,pl17,pl18,pl19,pl20,pl21,pl22,pl23,pl24,pl25,pl26,pl27,pl28,pl29,pl30,pl31,pl32,pl33,pl34,pl35,pl36,pl37,pl38,pl39,pl40,pl41,pl42,pl43,pl44,pl45,pl46,pl47,pl48,pl49,pl50,pl51,pl52,pl53,pl54,pl55,pl56];
%pRight = [pr1,pr2,pr3,pr4,pr5,pr6,pr7,pr8,pr9,pr10,pr11,pr12,pr13,pr14,pr15,pr16,pr17,pr18,pr19,pr20,pr21,pr22,pr23,pr24,pr25,pr26,pr27,pr28,pr29,pr30,pr31,pr32,pr33,pr34,pr35,pr36,pr37,pr38,pr39,pr40,pr41,pr42,pr43,pr44,pr45,pr46,pr47,pr48,pr49,pr50,pr51,pr52,pr53,pr54,pr55,pr56];
%pLeft = [pl2,pl6,pl10,pl13,pl14,pl15,pl16,pl17,pl18,pl19,pl20,pl21,pl22,pl23,pl24,pl25,pl26,pl27,pl28,pl29,pl30,pl31,pl32,pl33,pl34,pl35];
%pRight = [pr2,pr6,pr10,pr13,pr14,pr15,pr16,pr17,pr18,pr19,pr20,pr21,pr22,pr23,pr24,pr25,pr26,pr27,pr28,pr29,pr30,pr31,pr32,pr33,pr34,pr35];


pLeft = [pl1,pl2,pl3,pl4,pl5,pl6,pl7,pl8,pl9,pl10,pl11,pl12,pl13,pl14,pl15,pl16,pl17,pl18,pl19,pl20,pl21,pl22,pl23,pl24,pl25,pl26,pl27,pl28,pl29,pl30,pl31,pl32,pl33,pl34,pl35,pl36,pl37];
pRight = [pr1,pr2,pr3,pr4,pr5,pr6,pr7,pr8,pr9,pr10,pr11,pr12,pr13,pr14,pr15,pr16,pr17,pr18,pr19,pr20,pr21,pr22,pr23,pr24,pr25,pr26,pr27,pr28,pr29,pr30,pr31,pr32,pr33,pr34,pr35,pr36,pr37];

pLeft = pLeft / 2; pLeft(3,:) = ones(1,37);
pRight = pRight / 2; pRight(3,:) = ones(1,37);

%%%%%%%%%%%%%%
%%% cpselect
%load('points.mat');

%pLeft = [[randi(800) randi(600) 1]',pLeft];
%pRight = [[randi(800) randi(600) 1]',pRight];
%pLeft = [[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',pLeft];
%pRight = [[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',pRight];
%pLeft = [[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',pLeft];
%pRight = [[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',pRight];
%pLeft = [[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',pLeft];
%pRight = [[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',[randi(800) randi(600) 1]',pRight];

% Get correspondences
%[pLeft, pRight] = getCorrespondences();
% Remove outliers by RANSAC
%[pLeft, pRight] = myRansac(pLeft, pRight);

% Get camera calibrations (assuming one calibration across all images)
[K, fc, cc, alpha_c, kc] = CalibrateCameras();

% Remove Radial Distortion from points
pLeftTexture = pLeft; pRightTexture = pRight;
[pLeft, pRight] = removeRadialDistortion(pLeft, pRight, fc, cc, alpha_c, kc);

% Perform Eight Point Algorithm
F = NormalizedEightPointAlgorithm(pLeft,pRight);

% Draw epipolar lines
%[epipole1 epipole2] = drawEpipolarLines( pLeft, pRight, F );

% Draw correspondences
%DrawCorrespondences(pLeft,pRight);

% Compute Error
error = computeError(pLeft, pRight, F)

% Recover essential matrix
E = EssentialMatrix(F,K);
E

% Recover translation and rotation from fundamental matrix
[R, t] = ExtrinsicParameters(E, F, pLeft, pRight);
R
t

% Recover Camera Matrices
[P1, P2] = ProjectMatrixRecover(R, t, K);
P1
P2

% Triangulation
[XList] = Triangulation(pLeft, pRight, F, P1, P2);
%[new_points1, new_points2, X3D] = optimalTriangulation(F, pLeft', pRight', K, K, R, t);

% 3D Projection
Draw3DPoints(XList);

% Get Camera Locations
[C1 C2] = CameraLocation(P1,P2);
C1
C2

% Draw Cameras
%DrawCameras(C1,C2);

%DrawBackProjection(XList,P1,P2);

outputOBJ(XList, pLeftTexture, 'left.jpg');

keyboard;
