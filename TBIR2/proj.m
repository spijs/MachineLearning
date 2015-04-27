function [q_proj,i_proj] = project(queries,images, U, V)

queries
images
[rq,cq] = size(queries)
[rs,cs] = size(images)
size(U)
size(V)
U
V

for i = 1:rq
  q_proj(i,:) = queries(i,:)*U;
end

for j = 1:rs
  i_proj(j,:) = images(j,:)*V;
end

