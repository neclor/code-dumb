using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Dns;


public class DnsQuery {


	public ushort Id { get; set; }
	public bool IsResponse { get; set; }
	public byte Opcode {
		get;
		set => field = (byte)(value & 0x0F);
	}
	public bool AA { get; set; }
	public bool TC { get; set; }
	public bool RD { get; set; } = true;
	public bool RA { get; set; }
	public byte Rcode {
		get;
		set => field = (byte)(value & 0x0F);
	}
	public ushort QDCount { get; set; } = 1;
	public ushort ANCount { get; set; }
	public ushort NSCount { get; set; }
	public ushort ARCount { get; set; }




	byte[] header = new byte[12];


	







}
