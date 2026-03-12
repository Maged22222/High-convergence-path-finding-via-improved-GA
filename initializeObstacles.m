function obstacles = initializeObstacles(numObstacles, maxPosition, maxObstacleVelocity, obstacleRadius)
    % Generate random obstacle positions within the maximum position limits
    obstacles.position = rand(numObstacles, 3) .* repmat(maxPosition, numObstacles, 1);
    
    % Generate random obstacle velocities within the maximum velocity limits
    obstacles.velocity = rand(numObstacles, 3) .* repmat(maxObstacleVelocity, numObstacles, 1);
    
    % Set obstacle radii to a constant value
    obstacles.radius = obstacleRadius * ones(numObstacles, 1);
    hObstacles = scatter3(obstacles.position(:, 1), obstacles.position(:, 2), obstacles.position(:, 3));
    
    % Customize plot appearance (e.g., color, size)
    hObstacles.SizeData = 100; % Adjust marker size as needed
    hObstacles.MarkerFaceColor = 'k';
    hObstacles.MarkerEdgeColor = 'r';
end