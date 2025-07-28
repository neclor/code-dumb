using System;
using System.Net;
using System.Net.Sockets;


namespace Client;


internal class Client {


	static void Main() {
		string dnsServer = "127.0.0.1";
		int dnsPort = 5253; // порт твоего DNS-сервера
		string domain = "example.com";

		var client = new UdpClient();
		var serverEndpoint = new IPEndPoint(IPAddress.Parse(dnsServer), dnsPort);

		byte[] query = BuildDnsQuery(domain);

		Console.WriteLine($"Отправляем DNS-запрос для {domain} на {dnsServer}:{dnsPort}");
		client.Send(query, query.Length, serverEndpoint);

		var remoteEP = new IPEndPoint(IPAddress.Any, 0);
		var response = client.Receive(ref remoteEP);

		Console.WriteLine($"Получен ответ длиной {response.Length} байт от {remoteEP.Address}:{remoteEP.Port}");
		Console.WriteLine("Ответ в HEX:");

		Console.WriteLine(BitConverter.ToString(response).Replace("-", " "));
	}


	static byte[] BuildDnsQuery(string domain) {
		// Простейший DNS-запрос с ID 0x1234, 1 вопросом типа A (IPv4)
		// Без поддержки длинных имен и дополнительных опций — для теста

		var parts = domain.Split('.');
		int length = 12; // DNS header (12 bytes)
		foreach (var part in parts) {
			length += 1 + part.Length;
		}
		length += 5; // 1 byte нуль и 4 байта для типа и класса

		byte[] query = new byte[length];
		// ID
		query[0] = 0x12;
		query[1] = 0x34;
		// Flags: standard query
		query[2] = 0x01;
		query[3] = 0x00;
		// QDCOUNT (вопросы) = 1
		query[4] = 0x00;
		query[5] = 0x01;
		// ANCOUNT = 0
		query[6] = 0x00;
		query[7] = 0x00;
		// NSCOUNT = 0
		query[8] = 0x00;
		query[9] = 0x00;
		// ARCOUNT = 0
		query[10] = 0x00;
		query[11] = 0x00;

		int pos = 12;
		foreach (var part in parts) {
			query[pos++] = (byte)part.Length;
			foreach (var c in part) {
				query[pos++] = (byte)c;
			}
		}
		query[pos++] = 0x00; // конец имени

		// Тип A (0x0001)
		query[pos++] = 0x00;
		query[pos++] = 0x01;
		// Класс IN (0x0001)
		query[pos++] = 0x00;
		query[pos++] = 0x01;

		return query;
	}
}
