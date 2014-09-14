% Function to compute the strongly connected components of a graph.
% defined as "maximal sets such that within each set of nodes there 
%   exist paths connecting any node to any other node in the same set."

% Input: Adjacency matrix, directed
A = [0 1 0; 0 0 1; 0 1 1];
% more advanced example
A = [0 1 0 0 0 0 0 0;
0 0 1 0 1 1 0 0;
0 0 0 1 0 0 1 0;
0 0 1 0 0 0 0 1;
1 0 0 0 0 1 0 0;
0 0 0 0 0 0 1 0;
0 0 0 0 0 1 0 1;
0 0 0 0 0 0 0 1];

tmp = eye(size(A));
C = logical(tmp);
for i = 1:size(A,1)
    tmp = tmp*A;
    C = C | tmp;
end
clear tmp;
scc = C & C.'; % In the undirected (symmetric) case just take C.

% Output: Strongly connected components
scc

% Interpreting the output
comp = zeros(size(SCC,1),1);
for i = 1:size(comp,1)
    comp(i) = find(SCC(i,:),1,'first');
end
compUniq = unique(comp);
for i = 1:size(compUniq,1)
    nodes = find(comp == compUniq(i));
    fprintf('SCC %d has nodes: ',compUniq(i)); disp(nodes.')
end

