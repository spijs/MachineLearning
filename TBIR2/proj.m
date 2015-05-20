% This function projects the images and queries 
% matrices into the multimodal space defined by V and U
function [q_proj,i_proj] = project(images,queries, V, U)

disp('Size queries');
[rq,cq] = size(queries)
disp('Size images');
[rs,cs] = size(images)

 q_proj = queries*U;
 i_proj = images*V;

