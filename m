Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from internet2.beckhoff.com ([194.25.186.210]:54206 "EHLO
        Internet2.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbdLEOUm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 5 Dec 2017 09:20:42 -0500
From: =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To: Fabio Estevam <festevam@gmail.com>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>
CC: Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Philippe Ombredanne" <pombredanne@nexb.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Subject: RE: [PATCH v2 2/5] ARM: dts: imx53: add srtc node
Date: Tue, 5 Dec 2017 14:20:39 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB531C1F@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-3-linux-kernel-dev@beckhoff.com>
 <CAOMZO5DiRa1aLFHiFv_-_3J9LLuq-J06FHLQ4o7=r8hrftEpqQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DiRa1aLFHiFv_-_3J9LLuq-J06FHLQ4o7=r8hrftEpqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

PkZyb206IEZhYmlvIEVzdGV2YW0gW21haWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+U2VudDog
RGllbnN0YWcsIDUuIERlemVtYmVyIDIwMTcgMTU6MTQNCj5PbiBUdWUsIERlYyA1LCAyMDE3IGF0
IDEyOjA2IFBNLCAgPGxpbnV4LWtlcm5lbC1kZXZAYmVja2hvZmYuY29tPiB3cm90ZToNCj4NCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgIHNydGM6IHNydGNANTNmYTQwMDAgew0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg1My1ydGMiLCAi
ZnNsLGlteDI1LXJ0YyI7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAiZnNsLGlteDUzLXJ0YyI7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwweDUzZmE0MDAwIDB4NDAwMD47DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludGVycnVwdHMgPSA8MjQ+Ow0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZ0emljPjsNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGtzIElNWDVfQ0xLX1NSVENfR0FURT47DQo+PiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImlwZyI7DQo+DQo+
c3J0YyBub2RlIGhhcyBiZWVuIHJlbW92ZWQgaW4gbGludXgtbmV4dC4NCj4NCj5Zb3UgbmVlZCB0
byByZS1hZGQgaXQuDQpUaGFua3MgZm9yIHRoaXMgc3VwZXItZmFzdCByZXNwb25zZXMhDQpJIHdp
bGwgd2FpdCBhIGZldyBkYXlzIGZvciBtb3JlIHJldmlld2VycyBhbmQgdGhlbiBpbnRlZ3JhdGUg
eW91ciBjb21tZW50cyBpbiBhIHYzLiBJZiBub3RoaW5nIG1ham9yIHNob3cgdXAgSSB3aWxsIHdh
aXQgdW50aWwgdGhlIGlteDUzLmR0c2kgcmV2ZXJ0IGxhbmRlZCBpbiBMaW51cyB0cmVlLg0KDQpC
ZXN0IHJlZ2FyZHMsDQpQYXRyaWNrDQoNCkJlY2tob2ZmIEF1dG9tYXRpb24gR21iSCAmIENvLiBL
RyB8IE1hbmFnaW5nIERpcmVjdG9yOiBEaXBsLiBQaHlzLiBIYW5zIEJlY2tob2ZmDQpSZWdpc3Rl
cmVkIG9mZmljZTogVmVybCwgR2VybWFueSB8IFJlZ2lzdGVyIGNvdXJ0OiBHdWV0ZXJzbG9oIEhS
QSA3MDc1DQoNCg0K
