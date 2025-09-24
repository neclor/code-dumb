

namespace MathLibrary.Graph;


public class Graph(Vertex[]? vertices = default, Edge[]? edges = default) {

	private readonly List<Vertex> _vertices = vertices?.ToList() ?? [];
	private readonly List<Edge> _edges = edges?.ToList() ?? [];
	public IList<Vertex> Vertices => _vertices;
	public IList<Edge> Edges => _edges;





	public void AddVertex() {




	}






}
