Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from netsrv01.beckhoff.com ([62.159.14.10]:55686 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdK3Ng1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Nov 2017 08:36:27 -0500
From: =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To: Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
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
Date: Thu, 30 Nov 2017 13:36:22 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
 <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
In-Reply-To: <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

PkZyb206IFBoaWxpcHBlIE9tYnJlZGFubmUgW21haWx0bzpwb21icmVkYW5uZUBuZXhiLmNvbV0N
Cj5TZW50OiBEb25uZXJzdGFnLCAzMC4gTm92ZW1iZXIgMjAxNyAwOToxOA0KPj4NCj4+PiArLyoN
Cj4+PiArICogQ29weXJpZ2h0IChDKSAyMDA0LTIwMTEgRnJlZXNjYWxlIFNlbWljb25kdWN0b3Is
IEluYy4gQWxsIFJpZ2h0cw0KPlJlc2VydmVkLg0KPj4+ICsgKi8NCj4+PiArDQo+Pj4gKy8qDQo+
Pj4gKyAqIFRoZSBjb2RlIGNvbnRhaW5lZCBoZXJlaW4gaXMgbGljZW5zZWQgdW5kZXIgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYw0KPj4+ICsgKiBMaWNlbnNlLiBZb3UgbWF5IG9idGFpbiBhIGNvcHkg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+Pj4gKyAqIFZlcnNpb24gMiBvciBs
YXRlciBhdCB0aGUgZm9sbG93aW5nIGxvY2F0aW9uczoNCj4+PiArICoNCj4+PiArICogaHR0cDov
L3d3dy5vcGVuc291cmNlLm9yZy9saWNlbnNlcy9ncGwtbGljZW5zZS5odG1sDQo+Pj4gKyAqIGh0
dHA6Ly93d3cuZ251Lm9yZy9jb3B5bGVmdC9ncGwuaHRtbA0KPj4+ICsgKi8NCj4NCj5FeGFjdGx5
IQ0KPkFuZCB3aGlsZSB5b3UgYXJlIGl0ICwgeW91IGNvdWxkIHJlcGxhY2UgdGhlIGJvaWxlcnBs
YXRlIGxpY2Vuc2UgdGV4dA0KPndpdGggdGhlIFNQRFggaWQuDQo+LS0NCg0KSG93IHdvdWxkIGEg
cGVyZmVjdCBoZWFkZXIgbG9vayBsaWtlPw0KTG9va2luZyBhdCA6DQpnaXQgc2hvdyBiMjQ0MTMx
ODBmNTYwMGJjYjNiYjcwZmJlZDVjZjE4NmI2MDg2NGJkIC0tIGRyaXZlcnMvDQphbmQ6DQpnaXQg
Z3JlcCBTUERYIC0tIERvY3VtZW50YXRpb24vDQoNCml0IGNvdWxkIGJlOg0KKy8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQorLyoNCisgKiBDb3B5cmlnaHQgKEMpIDIwMDQt
MjAxMSBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciwgSW5jLiBBbGwgUmlnaHRzDQorICovDQpvcjoN
CisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKy8qDQorICogQ29weXJpZ2h0
IChDKSAyMDA0LTIwMTEgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYy4gQWxsIFJpZ2h0cw0K
KyAqLw0KDQpQZXJzb25hbGx5IEkgd291bGQgcHJlZmVyOg0KKy8qDQorICogQ29weXJpZ2h0IChD
KSAyMDA0LTIwMTEgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYy4gQWxsIFJpZ2h0cw0KKyAq
DQorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCisgKi8NCg0KU28sIGlzIHRo
ZXJlIGFueSBndWlkZWxpbmU/DQoNClRvIGJlIGNsZWFyOiBJIGRvbid0IHdhbnQgdG8gd2FzdGUg
YW55b25lJ3MgdGltZSBvbiB0aGlzLiBCdXQgYXMgU1BEWA0Kd2FzIGludGVuZGVkIGZvciBhdXRv
bWF0aW9uLCBJIHRoaW5rIGl0IG1pZ2h0IGJlIGdvb2QgdG8gdHJ5IGhhdmluZw0Kc29tZSBjb21t
b24gcGF0dGVybiBoZXJlLg0KSSBkb24ndCB3YW50IHRvIHN0YXJ0IGEgZGlzY3Vzc2lvbiwgc28g
aW4gY2FzZSB0aGVyZSBpcyBubyBndWlkZWxpbmUgSSB3aWxsDQpqdXN0IHRha2UgdGhlIC8qIFNQ
RFggKi8gaW4gZmlyc3RsaW5lIHZlcnNpb24uDQoNClJlZ2FyZHMsIFBhdHJpY2sNCg0KQmVja2hv
ZmYgQXV0b21hdGlvbiBHbWJIICYgQ28uIEtHIHwgTWFuYWdpbmcgRGlyZWN0b3I6IERpcGwuIFBo
eXMuIEhhbnMgQmVja2hvZmYNClJlZ2lzdGVyZWQgb2ZmaWNlOiBWZXJsLCBHZXJtYW55IHwgUmVn
aXN0ZXIgY291cnQ6IEd1ZXRlcnNsb2ggSFJBIDcwNzUNCg0KDQo=
