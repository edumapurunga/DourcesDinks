function [Dources, Dinks, varargout] = findDourceDink(G)
%
% Find all dources and dinks from a general dynamic network
%
% 
% Inputs:
%      G - adjacency matrix (1 - existing directed edge, 0 for absence) 
%
% Outputs:
%     Dources - set of dources.
%     Dinks   - set of dinks.
% Optional:
%     Sources - set of sources.
%     Sinks   - set of sinks.
%
%
% Author: Eduardo Mapurunga.

n = size(G, 2);
isSource = false;
isSink = false;

Sources = [];
Sinks = [];
Dources = [];
Dinks = [];

for i = 1:n
  % Check if a node is a source
  if sum(G(i, :)) == 0
     isSource = true;
     Sources = [Sources, i];
  end
  % Check if this node
  if sum(G(:, i)) == 0
     isSink = true;
     Sinks = [Sinks, i];
  end
  % Check if it is a dource
  if ~(isSource || isSink)
     inneighbors = find(G(i, :));
     outneighbors = find(G(:, i));
     Gaux = G(outneighbors, inneighbors); 
     for j = 1:length(inneighbors)
        if all(Gaux(:, j))
            % It is a dink
            Dinks = [Dinks, i];
            break;
        end
     end
     for j = 1:length(outneighbors)
       if all(Gaux(j, :))
           % It is a dource
           Dources = [Dources, i];
           break;
       end
     end
     
  end
  isSink = false;
  isSource = false;
end

varargout{1} = Sources;
varargout{2} = Sinks;