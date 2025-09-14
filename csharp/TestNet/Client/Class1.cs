using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;


namespace Client;

internal class SocksProxy {


	const int Port = 1080;


	TcpListener listener;


	SocksProxy() {
		listener = new TcpListener(IPAddress.Any, Port);
		listener.Start();
		Run();
	}

	void Run() {
		while (true) {
			TcpClient client = listener.AcceptTcpClient();
			HandleClient(client);
		}
	}

	void HandleClient(TcpClient client) {
		NetworkStream clientStream = client.GetStream();



	}


}
