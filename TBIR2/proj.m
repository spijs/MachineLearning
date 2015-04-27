function [q_proj,i_proj] = project(images,queries, U, V)

disp('Size queries');
[rq,cq] = size(queries)
disp('Size images');
[rs,cs] = size(images)

for i = 1:rq
  q_proj(i,:) = queries(i,:)*U;
end

for j = 1:rs
  i_proj(j,:) = images(j,:)*V;
end

