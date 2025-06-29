namespace AlbionBlackMarketBot
{
    partial class MainForm
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.TreeNode treeNode3 = new System.Windows.Forms.TreeNode("Armor");
            System.Windows.Forms.TreeNode treeNode4 = new System.Windows.Forms.TreeNode("Items", new System.Windows.Forms.TreeNode[] {
            treeNode3});
            this.ScanBlackMarketButton = new System.Windows.Forms.Button();
            this.BuyButton = new System.Windows.Forms.Button();
            this.treeView1 = new System.Windows.Forms.TreeView();
            this.SuspendLayout();
            // 
            // ScanBlackMarketButton
            // 
            this.ScanBlackMarketButton.BackColor = System.Drawing.SystemColors.WindowText;
            this.ScanBlackMarketButton.Location = new System.Drawing.Point(12, 12);
            this.ScanBlackMarketButton.Name = "ScanBlackMarketButton";
            this.ScanBlackMarketButton.Size = new System.Drawing.Size(281, 99);
            this.ScanBlackMarketButton.TabIndex = 0;
            this.ScanBlackMarketButton.Text = "Scan Black Market";
            this.ScanBlackMarketButton.UseVisualStyleBackColor = false;
            this.ScanBlackMarketButton.Click += new System.EventHandler(this.ScanBlackMarketButton_Click);
            // 
            // BuyButton
            // 
            this.BuyButton.BackColor = System.Drawing.SystemColors.WindowText;
            this.BuyButton.ForeColor = System.Drawing.SystemColors.Window;
            this.BuyButton.Location = new System.Drawing.Point(12, 349);
            this.BuyButton.Name = "BuyButton";
            this.BuyButton.Size = new System.Drawing.Size(279, 134);
            this.BuyButton.TabIndex = 1;
            this.BuyButton.Text = "Buy";
            this.BuyButton.UseVisualStyleBackColor = false;
            this.BuyButton.Click += new System.EventHandler(this.BuyButton_Click);
            // 
            // treeView1
            // 
            this.treeView1.BackColor = System.Drawing.SystemColors.WindowText;
            this.treeView1.CheckBoxes = true;
            this.treeView1.ForeColor = System.Drawing.SystemColors.Window;
            this.treeView1.LineColor = System.Drawing.Color.White;
            this.treeView1.Location = new System.Drawing.Point(655, 275);
            this.treeView1.Name = "treeView1";
            treeNode3.Name = "Armor";
            treeNode3.Tag = "Armor";
            treeNode3.Text = "Armor";
            treeNode4.Name = "Items";
            treeNode4.Text = "Items";
            this.treeView1.Nodes.AddRange(new System.Windows.Forms.TreeNode[] {
            treeNode4});
            this.treeView1.Size = new System.Drawing.Size(298, 425);
            this.treeView1.TabIndex = 2;
            // 
            // MainForm
            // 
            this.BackColor = System.Drawing.SystemColors.WindowText;
            this.ClientSize = new System.Drawing.Size(1159, 860);
            this.Controls.Add(this.treeView1);
            this.Controls.Add(this.BuyButton);
            this.Controls.Add(this.ScanBlackMarketButton);
            this.ForeColor = System.Drawing.SystemColors.Window;
            this.Name = "MainForm";
            this.Text = "AlbionBlackMarketBot";
            this.ResumeLayout(false);

        }

        #endregion

        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private Button ScanBlackMarketButton;
        private Button BuyButton;
        private TreeView treeView1;
    }
}