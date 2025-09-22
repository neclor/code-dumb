using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Linq;

namespace MathLibrary.Graph;

public class Edge {

	public Vertex? From {
		get;
		set {
			field?._edges.Remove(this);
			field = value;
			field?._edges.Add(this);
		}
	}
	public Vertex? To {
		get;
		set {
			field?._edges.Remove(this);
			field = value;
			field?._edges.Add(this);
		}
	}

	public bool Directed { get; set; }
	public float Weight { get; set; }
	public bool IsLoop => From == To;

	public Edge(Vertex from = default, Vertex to = default, bool directed = false, float weight = 0) {
		From = from;
		To = to;
		Directed = directed;
		Weight = weight;
	}

	public void Remove() {

		From = null;


	}

	public override string ToString() => From.Name + " -> " + To.Name;
}
