namespace console_winforms_app;

public partial class Form1 : Form {
	public Form1() {
		InitializeComponent();
	}

	int n = 0;

	private void timer1_Tick(object sender, EventArgs e) {
		this.label1.Text = $"{n++}";
	}
}
