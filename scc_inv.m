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

% Randomize diagonal and multiply by eps to ensure invertability 
A1 = A;
A1(logical(eye(size(A)))) = rand(size(A,1),1);
D = eye(size(A1)) - eps*A1;
C = inv(D) > 0;
SCC = C & C.';  % In the undirected (symmetric) case just take C.

% Output: Strongly connected components
SCC

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


%% Sparse version
A = sparse(A);
A1 = A;
A1(logical(speye(size(A)))) = rand(size(A,1),1);
D = speye(size(A1)) - eps*A1;
C = inv(D) > 0;
SCC = C & C.';  % In the undirected (symmetric) case just take C.

SCC

%% Plot results
% nodesPerRow = 4;
% coordX = mod( (0:size(A)-1)', nodesPerRow);
% coordY = floor( (0:size(A)-1)' ./ nodesPerRow);
% coord = [coordX coordY];
% gplot(A,coord)

bgOrig = biograph( A & ~logical(eye(size(A))) );
view(bgOrig);

bgSCC = biograph( SCC & ~logical(eye(size(SCC))) );
view(bgSCC);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%A = A | eye(size(A));
%alpha = max(diag(A))+1;
%D = eye(size(A)) - (1/alpha).*A;

% A = [0 1 0; 0 0 1; 0 1 0];
% A = rand(10000);
% tic
% m = max(diag(A))+1;
% tv = toc;
% tv
% 
% tic
% m = trace(A)+1;
% tv = toc;
% tv