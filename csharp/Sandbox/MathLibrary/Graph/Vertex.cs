namespace MathLibrary.Graph;


public class Vertex(string name = "Untitled") {

	public string Name { get; set; } = name ?? throw new ArgumentNullException(nameof(name));

	internal readonly List<Edge> _edges = [];

	public IReadOnlyList<Edge> Edges => _edges;
	public IReadOnlyList<Edge> InEdges => [.. _edges.Where(e => e.Directed && (e.To == this))];
	public IReadOnlyList<Edge> OutEdges => [.. _edges.Where(e => e.Directed && (e.From == this))];
	public IReadOnlyList<Edge> UndirectedEdges => [.. _edges.Where(e => !e.Directed && (e.From == this || e.To == this))];
	public IReadOnlyList<Edge> LoopEdges => [.. _edges.Where(e => e.IsLoop)];

	public IReadOnlyList<Vertex> Neighbors => [.. _edges.Select(e => e.From == this ? e.To : e.From).Distinct()];
	public IReadOnlyList<Vertex> Predecessors => [.. InEdges.Select(e => e.From).Distinct()];
	public IReadOnlyList<Vertex> Successors => [.. OutEdges.Select(e => e.To).Distinct()];

	public override string ToString() => Name;
}
