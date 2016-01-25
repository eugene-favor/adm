####Issues of protocols:####

**Flow control** The generation of messages by the receiving system that
instruct the sending system to speed up or slow down its transmission
of data

**Packet acknowledgment** The transmission of a return message from
the receiving system to the sending system to acknowledge the receipt
of data

**Error detection** The use of codes by the sending system to verify that
the data sent wasn’t damaged during transmission

**Error correction** The retransmission of data that was lost or damaged
during the initial transmission

**Segmentation** The division of long streams of data into smaller ones for
more efficient transfer

**Data encryption** A function that uses cryptographic keys to protect data
transmitted across a network

**Data compression** A method for reducing the size of data transmitted
across a network by eliminating redundant information

**Typical protocols used in each layer of OSI:**

```
Application HTTP, SMTP, FTP, Telnet
Presentation ASCII, MPEG, JPEG, MIDI
Session NetBIOS, SAP, SDP, NWLink
Transport TCP, UDP, SPX
Network IP, ICMP, ARP, RIP, IPX
Data Link Ethernet, Token Ring, FDDI, AppleTalk
```

Network devices:

**hub** - half-duplex mode

Hub Broadcast traffic to all computers conneted to it ports and reject if not intended for.

**switches** - full-duplex devices that can
send and receive data synchronously

Switches store the Layer 2 address of every connected device in a CAM
table, which acts as a kind of traffic cop. When a packet is transmitted, the
switch reads the Layer 2 header information in the packet and, using the
CAM table as reference, determines which port(s) to send the packet to.
Switches only send packets to specific ports, which greatly reduces network
traffic.