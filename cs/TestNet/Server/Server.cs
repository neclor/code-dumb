using System;
using System.Net;
using System.Net.Sockets;



namespace DnsTunnel.Server;


internal class Server {


	const int Port = 5253;


	static void Main() {
		using UdpClient udpClient = new UdpClient(Port);


		while (true) {
			IPEndPoint? remoteEp = null;
			byte[] data = udpClient.Receive(ref remoteEp);

			Console.WriteLine($"Получен запрос от {remoteEp.Address}:{remoteEp.Port}, длина {data.Length} байт");

			udpClient.Send(data, data.Length, remoteEp);
		}
	}
}
