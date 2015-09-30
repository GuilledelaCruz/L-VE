require 'Graph'
require 'Vertex'
require 'Edge'

function mapgraph()
	graph = graphmodule

	v1 = vertexmodule.createVertex(100, 100)
	v2 = vertexmodule.createVertex(200, 100)
	v3 = vertexmodule.createVertex(200, 150)
	v4 = vertexmodule.createVertex(400, 200)
	v5 = vertexmodule.createVertex(500, 300)
	v6 = vertexmodule.createVertex(300, 400)
	v7 = vertexmodule.createVertex(650, 400)
	v8 = vertexmodule.createVertex(700, 500)
	v9 = vertexmodule.createVertex(350, 520)

	graph = graphmodule.addVertex(graph, v1)
	graph = graphmodule.addVertex(graph, v2)
	graph = graphmodule.addVertex(graph, v3)
	graph = graphmodule.addVertex(graph, v4)
	graph = graphmodule.addVertex(graph, v5)
	graph = graphmodule.addVertex(graph, v6)
	graph = graphmodule.addVertex(graph, v7)
	graph = graphmodule.addVertex(graph, v8)
	graph = graphmodule.addVertex(graph, v9)

	a1 = edgemodule.createEdge(v1, v2)
	a2 = edgemodule.createEdge(v2, v3)
	a3 = edgemodule.createEdge(v3, v1)
	a4 = edgemodule.createEdge(v4, v5)
	a5 = edgemodule.createEdge(v5, v6)
	a6 = edgemodule.createEdge(v6, v4)
	a7 = edgemodule.createEdge(v7, v8)
	a8 = edgemodule.createEdge(v8, v9)
	a9 = edgemodule.createEdge(v9, v7)

	graph = graphmodule.addEdge(graph, a1)
	graph = graphmodule.addEdge(graph, a2)
	graph = graphmodule.addEdge(graph, a3)
	graph = graphmodule.addEdge(graph, a4)
	graph = graphmodule.addEdge(graph, a5)
	graph = graphmodule.addEdge(graph, a6)
	graph = graphmodule.addEdge(graph, a7)
	graph = graphmodule.addEdge(graph, a8)
	graph = graphmodule.addEdge(graph, a9)

	return graph
end
