﻿namespace console_winforms_app;

partial class Form1
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
	private void InitializeComponent() {
		components = new System.ComponentModel.Container();
		timer1 = new System.Windows.Forms.Timer(components);
		label1 = new Label();
		SuspendLayout();
		// 
		// timer1
		// 
		timer1.Enabled = true;
		timer1.Interval = 1000;
		timer1.Tick += timer1_Tick;
		// 
		// label1
		// 
		label1.AutoSize = true;
		label1.Font = new Font("Segoe UI", 36F, FontStyle.Regular, GraphicsUnit.Point, 204);
		label1.Location = new Point(139, 125);
		label1.Name = "label1";
		label1.Size = new Size(307, 128);
		label1.TabIndex = 0;
		label1.Text = "label1";
		// 
		// Form1
		// 
		AutoScaleDimensions = new SizeF(13F, 32F);
		AutoScaleMode = AutoScaleMode.Font;
		ClientSize = new Size(800, 450);
		Controls.Add(label1);
		Name = "Form1";
		Text = "Form1";
		ResumeLayout(false);
		PerformLayout();
	}

	#endregion

	private System.Windows.Forms.Timer timer1;
	private Label label1;
}
