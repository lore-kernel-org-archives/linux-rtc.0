Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from internet2.beckhoff.com ([194.25.186.210]:65168 "EHLO
        Internet2.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdK3OY0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Nov 2017 09:24:26 -0500
From: =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To: Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] rtc: add mxc driver for i.MX53
Date: Thu, 30 Nov 2017 14:24:22 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB531375@NT-Mail07.beckhoff.com>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
 <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
 <CAOFm3uHAXKr7KiFeyvYb77jot8M_4rH-cqt2Ze3AbnOiZ_wiwg@mail.gmail.com>
In-Reply-To: <CAOFm3uHAXKr7KiFeyvYb77jot8M_4rH-cqt2Ze3AbnOiZ_wiwg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

PkZyb206IFBoaWxpcHBlIE9tYnJlZGFubmUgW21haWx0bzpwb21icmVkYW5uZUBuZXhiLmNvbV0N
Cj5TZW50OiBEb25uZXJzdGFnLCAzMC4gTm92ZW1iZXIgMjAxNyAxNTowMA0KPk9uIFRodSwgTm92
IDMwLCAyMDE3IGF0IDI6MzYgUE0sIFBhdHJpY2sgQnLDvG5uIDxQLkJydWVubkBiZWNraG9mZi5j
b20+DQo+d3JvdGU6DQo+DQo+VGhvbWFzOg0KPkkgdGVuZCB0byBwcmVmZXIgYXMgTGludXMgcG9p
bnRlZCB0aGUgLy8gc3R5bGUgdGhyb3VnaG91dCB3aGVuIHRoZXJlDQo+aXMgb25seSBhIGxpY2Vu
c2UgYW5kIGNvcHlyaWdodCBpbnZvbHZlZC4gSGVyZSB0aGlzIHdvdWxkIG1lYW46DQo+DQo+PiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsvLyBDb3B5cmlnaHQgKGMp
IDIwMDQtMjAxMSBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciwgSW5jLiBBbGwgUmlnaHRzDQo+UmVz
ZXJ2ZWQuDQo+DQo+V2hhdCdzIHlvdSB0YWtlIHNpbmNlIHlvdSB3cm90ZSB0aGUgZG9jIGZvciB0
aGlzPyBBbmQgaXMgdGhlcmUgc3RpbGwNCj5zb21lIHVwZGF0ZXMgbmVlZGVkIGZvciB0aGlzIHNp
bmNlIHlvdXIgbGFzdCBwYXRjaCBzZXQ/DQo+DQpXaGlsZSBsb29raW5nIGNsb3NlciBpbnRvIGRp
ZmZlcmVudCBmaWxlcyBJIHRoaW5rIGl0IHdvdWxkIGJlY29tZSBtdWx0aWxpbmUgYWdhaW46DQor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCisvKg0KKyAqIFJlYWwgVGltZSBD
bG9jayAoUlRDKSBEcml2ZXIgZm9yIGkuTVg1Mw0KKyAqIENvcHlyaWdodCAoYykgMjAwNC0yMDEx
IEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQorICogQ29weXJpZ2h0IChjKSAyMDE3IEJl
Y2tob2ZmIEF1dG9tYXRpb24gR21iSCAmIENvLiBLRw0KKyAqLw0KDQo+DQo+UGF0cmljazoNCj5T
aWRlIG5vdGUgYSB0cmFpbGluZyAgIkFsbCBSaWdodHMgUmVzZXJ2ZWQuIiBpbiBhIGNvcHlyaWdo
dCBzdGF0ZW1lbnQNCj5pcyBuZXZlciBuZWVkZWQsIGV2ZW4gdGhvdWdoIGN1c3RvbWFyaWx5IGNh
cmdvIGN1bHRlZCBieSBldmVyeW9uZSwNCj5pbmNsdWRpbmcgbWUuDQo+U3RhcnRlZCBpbiAxOTEw
LCBpdCBiZWNvbWUgZnVsbHkgb2Jzb2xldGUgaW4gMjAwMCB0aGFua3MgdG8gTmljYXJhZ3VhDQo+
WzFdIHNpZ25pbmcgdGhlIEJlcm5lIGNvbnZlbnRpb24uDQo+DQo+WzFdIGh0dHBzOi8vZW4ud2lr
aXBlZGlhLm9yZy93aWtpL0FsbF9yaWdodHNfcmVzZXJ2ZWQNCkludGVyZXNzdGluZy4gSSBqdXN0
IGtlcHQgaXQgYmVjYXVzZSBpdCB3YXMgaW4gdGhlIG9yaWdpbmFsIGZpbGUgZnJvbSBmcmVlc2Nh
bGUuDQpCdXQgd2l0aCB0aGlzIGJhY2tncm91bmQsIEkgdGhpbmsgaXQncyBmaW5lIHRvIGRyb3Ag
aXQsIG5vdy4NCg0KVGhhbmtzLA0KUGF0cmljaw0KQmVja2hvZmYgQXV0b21hdGlvbiBHbWJIICYg
Q28uIEtHIHwgTWFuYWdpbmcgRGlyZWN0b3I6IERpcGwuIFBoeXMuIEhhbnMgQmVja2hvZmYNClJl
Z2lzdGVyZWQgb2ZmaWNlOiBWZXJsLCBHZXJtYW55IHwgUmVnaXN0ZXIgY291cnQ6IEd1ZXRlcnNs
b2ggSFJBIDcwNzUNCg0KDQo=
