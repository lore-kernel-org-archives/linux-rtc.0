Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from netsrv01.beckhoff.com ([62.159.14.10]:57625 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdLLFFR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Dec 2017 00:05:17 -0500
From: =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Rob Herring <robh@kernel.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Patrick Bruenn <p.bruenn@beckhoff.compaste>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Fabio Estevam" <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        "Noel Vellemans" <Noel.Vellemans@visionbms.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Subject: RE: [PATCH v2 1/5] dt-bindings: rtc: add bindings for i.MX53 SRTC
Date: Tue, 12 Dec 2017 05:05:14 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB532561@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-2-linux-kernel-dev@beckhoff.com>
 <20171206215436.lwttn445wjilh3wo@rob-hp-laptop>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB53233C@NT-Mail07.beckhoff.com>
 <CAOMZO5DoiLW3DxLF=agHua9jO-+LgWA3xw6h7kyj_uot47pkjw@mail.gmail.com>
In-Reply-To: <CAOMZO5DoiLW3DxLF=agHua9jO-+LgWA3xw6h7kyj_uot47pkjw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

PkZyb206IEZhYmlvIEVzdGV2YW0gW21haWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+U2VudDog
RGllbnN0YWcsIDEyLiBEZXplbWJlciAyMDE3IDAwOjA4DQo+SGkgUGF0cmljaywNCj4NCkhpIEZh
YmlvLA0KPk9uIE1vbiwgRGVjIDExLCAyMDE3IGF0IDU6MDggQU0sIFBhdHJpY2sgQnLDvG5uIDxQ
LkJydWVubkBiZWNraG9mZi5jb20+DQo+d3JvdGU6DQo+DQo+Pj5ydGNALi4uDQo+Pj4NCj4+IFRo
ZSBydGMgZm9yIHdoaWNoIHRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBpcyBlbWJlZGRlZCB3aXRo
aW4gYSBmdW5jdGlvbg0KPmJsb2NrIGNhbGxlZA0KPj4gIlNlY3VyZSBSZWFsIFRpbWUgQ2xvY2si
LiBUaGlzIGRyaXZlciBkb2Vzbid0IHV0aWxpemUgYWxsIG9mIHRoZSBoYXJkd2FyZQ0KPmZlYXR1
cmVzIGJ5DQo+PiBub3cuIEJ1dCBtYXliZSBzb21lb25lIGVsc2Ugd2FudHMgdG8gZXh0ZW5kIHRo
ZSBmdW5jdGlvbmFsaXRpZXMsIGxhdGVyLg0KPj4gRm9yIHRoYXQgcG9zc2liaWxpdHkgSSB3YW50
ZWQgdG8gbmFtZSB0aGUgbm9kZSAic3J0YyIuIFNob3VsZCBJIHN0aWxsIGNoYW5nZQ0KPnRoaXM/
DQo+Pg0KPj4gSSBiZWxpZXZlIHlvdSBoYXZlIGEgbXVjaCBiZXR0ZXIgdW5kZXJzdGFuZGluZyBv
ZiB3aGF0IHNob3VsZCBiZSBkb25lDQo+aGVyZS4gSSBkb24ndA0KPj4gd2FudCB0byBhcmd1ZSB3
aXRoIHlvdSwganVzdCB0aG91Z2h0IHlvdSBtaWdodCBub3QgaGFkIHRoYXQgaW5mb3JtYXRpb24u
IFNvDQo+aWYgSSBhbQ0KPj4gd3JvbmcganVzdCB0ZWxsIG1lIGFuZCBJIHdpbGwgY2hhbmdlIGl0
IHdpdGhvdXQgZnVydGhlciAiY29tcGxhaW5pbmciLg0KPg0KPkZyb20gdGhlIERldmljZXRyZWUg
U3BlY2lmaWNhdGlvbiBkb2N1bWVudDoNCj4NCj4iR2VuZXJpYyBOYW1lcyBSZWNvbW1lbmRhdGlv
bg0KPg0KPlRoZSBuYW1lIG9mIGEgbm9kZSBzaG91bGQgYmUgc29tZXdoYXQgZ2VuZXJpYywgcmVm
bGVjdGluZyB0aGUgZnVuY3Rpb24NCj5vZiB0aGUgZGV2aWNlIGFuZCBub3QgaXRzIHByZWNpc2Ug
cHJvZ3JhbS0NCj5taW5nIG1vZGVsLiBJZiBhcHByb3ByaWF0ZSwgdGhlIG5hbWUgc2hvdWxkIGJl
IG9uZSBvZiB0aGUgZm9sbG93aW5nIGNob2ljZXM6DQo+Li4uDQo+cnRjDQo+Ig0KPg0KPlNvIGJl
dHRlciB1c2UgJ3J0YycgYXMgc3VnZ2VzdGVkIGJ5IFJvYi4NCg0KVGhhbmtzIGZvciB0aGlzIGNs
YXJpZmljYXRpb24uIEkgd2lsbCB3YWl0IGEgZmV3IGRheXMgZm9yIG1vcmUgY29tbWVudHMgb24g
dGhlIHJlc3Qgb2YgdGhlIGRyaXZlciBhbmQgdGhlbiBzZW5kIGEgdjQuDQoNClJlZ2FyZHMsIFBh
dHJpY2sNCkJlY2tob2ZmIEF1dG9tYXRpb24gR21iSCAmIENvLiBLRyB8IE1hbmFnaW5nIERpcmVj
dG9yOiBEaXBsLiBQaHlzLiBIYW5zIEJlY2tob2ZmDQpSZWdpc3RlcmVkIG9mZmljZTogVmVybCwg
R2VybWFueSB8IFJlZ2lzdGVyIGNvdXJ0OiBHdWV0ZXJzbG9oIEhSQSA3MDc1DQoNCg0K
