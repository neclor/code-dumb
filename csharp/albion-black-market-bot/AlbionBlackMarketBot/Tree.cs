namespace AlbionBlackMarketBot;

public record Tree(string Id, string Name, string NameRus, Tree[] Children = null)
{
    Tree[] SafeChildren => Children ?? Array.Empty<Tree>();

    public bool IsLeaf => SafeChildren.Length == 0;

	public IEnumerable<Tree> All =>
        SafeChildren.SelectMany(o => o.All).Prepend(this);

	public IEnumerable<Tree> AllLeaves =>
		All.Where(o => o.IsLeaf);

	public IEnumerable<Tree> Filtered(string id) =>
        Id == id
            ? All
            : SafeChildren.SelectMany(o => o.Filtered(id));

	public IEnumerable<Tree> FilteredLeaves(string id) =>
		Filtered(id).Where(o => o.IsLeaf);
}
