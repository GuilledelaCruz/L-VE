graph = {vertex = {}, edges = {}}

function graph.getVertexs(g)
	return g.vertex
end

function graph.getEdges(g)
	return g.edges
end

function graph.addVertex(g, v)
	table.insert(g.vertex, v)
	return g
end

function graph.addEdge(g, a)
	table.insert(g.edges, a)
	return g
end

function graph.draw(love, g)
	local s = love.graphics.getPointSize() + 2;
   	love.graphics.setPointSize(s);

	for i, vertex in ipairs(g.vertex) do
		love.graphics.point(vertex.x, vertex.y)
	end

	for j, edge in ipairs(g.edges) do
		love.graphics.line(edge.v1.x, edge.v1.y, edge.v2.x, edge.v2.y)
	end
   	love.graphics.setPointSize(s - 2);
end

return  graph
