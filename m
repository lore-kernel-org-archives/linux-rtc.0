Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17556 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755826AbeEIHVn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 May 2018 03:21:43 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexandre TORGUE <alexandre.torgue@st.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh@kernel.org>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for
 st,syscfg property
Date: Wed, 9 May 2018 07:21:00 +0000
Message-ID: <bf861b1b-5a55-e144-5999-b41d9d2cea8b@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
 <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
 <20180427025803.mn32y5xle2p6knn6@rob-hp-laptop>
 <20180503205351.GE10960@piout.net>
 <a2cbe252-c957-103d-aae1-4a8fce9116fa@st.com>
In-Reply-To: <a2cbe252-c957-103d-aae1-4a8fce9116fa@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

SGksDQoNCk9uIDA1LzA0LzIwMTggMDk6NDAgQU0sIEFsZXhhbmRyZSBUb3JndWUgd3JvdGU6DQo+
IEhpIEFsZXhhbmRyZSwNCj4gDQo+IE9uIDA1LzAzLzIwMTggMTA6NTMgUE0sIEFsZXhhbmRyZSBC
ZWxsb25pIHdyb3RlOg0KPj4gQW1lbGllLA0KPj4NCj4+IE9uIDI2LzA0LzIwMTggMjE6NTg6MDMt
MDUwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4gT24gVGh1LCBBcHIgMTksIDIwMTggYXQgMDM6
MjE6NDJQTSArMDIwMCwgQW1lbGllIERlbGF1bmF5IHdyb3RlOg0KPj4+PiBSVEMgZHJpdmVyIHNo
b3VsZCBub3QgYmUgYXdhcmUgb2YgdGhlIFBXUiByZWdpc3RlcnMgb2Zmc2V0IGFuZCBiaXRzDQo+
Pj4+IHBvc2l0aW9uLiBGdXJ0aGVybW9yZSwgd2UgY2FuIGltYWdpbmUgdGhhdCBEaXNhYmxlIEJh
Y2t1cCBQcm90ZWN0aW9uIA0KPj4+PiAoREJQKQ0KPj4+PiByZWxhdGl2ZSByZWdpc3RlciBhbmQg
Yml0IG1hc2sgY291bGQgY2hhbmdlIGRlcGVuZGluZyBvbiB0aGUgU29DLiBTbyANCj4+Pj4gdGhp
cw0KPj4+PiBwYXRjaCBtb3ZlcyBzdCxzeXNjZmcgcHJvcGVydHkgZnJvbSBzaW5nbGUgcHdyY2Zn
IHBoYW5kbGUgdG8gcHdyY2ZnDQo+Pj4+IHBoYW5kbGUvb2Zmc2V0L21hc2sgdHJpcGxldC4NCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlA
c3QuY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3J0Yy9zdCxzdG0zMi1ydGMudHh0IHwgMTAgDQo+Pj4+ICsrKysrKy0tLS0NCj4+Pj4gwqAg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvc3Qs
c3RtMzItcnRjLnR4dCANCj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cnRjL3N0LHN0bTMyLXJ0Yy50eHQNCj4+Pj4gaW5kZXggYTY2NjkyYS4uMDBmOGI1ZCAxMDA2NDQN
Cj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9zdCxzdG0z
Mi1ydGMudHh0DQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
dGMvc3Qsc3RtMzItcnRjLnR4dA0KPj4+PiBAQCAtMTQsOCArMTQsMTAgQEAgUmVxdWlyZWQgcHJv
cGVydGllczoNCj4+Pj4gwqDCoMKgwqDCoCBJdCBpcyByZXF1aXJlZCBvbmx5IG9uIHN0bTMyaDcu
DQo+Pj4+IMKgIC0gaW50ZXJydXB0LXBhcmVudDogcGhhbmRsZSBmb3IgdGhlIGludGVycnVwdCBj
b250cm9sbGVyLg0KPj4+PiDCoCAtIGludGVycnVwdHM6IHJ0YyBhbGFybSBpbnRlcnJ1cHQuDQo+
Pj4+IC0tIHN0LHN5c2NmZzogcGhhbmRsZSBmb3IgcHdyY2ZnLCBtYW5kYXRvcnkgdG8gZGlzYWJs
ZS9lbmFibGUgYmFja3VwIA0KPj4+PiBkb21haW4NCj4+Pj4gLcKgIChSVEMgcmVnaXN0ZXJzKSB3
cml0ZSBwcm90ZWN0aW9uLg0KPj4+PiArLSBzdCxzeXNjZmc6IHBoYW5kbGUvb2Zmc2V0L21hc2sg
dHJpcGxldC4gVGhlIHBoYW5kbGUgdG8gcHdyY2ZnIA0KPj4+PiB1c2VkIHRvDQo+Pj4+ICvCoCBh
Y2Nlc3MgY29udHJvbCByZWdpc3RlciBhdCBvZmZzZXQsIGFuZCBjaGFuZ2UgdGhlIGRicCAoRGlz
YWJsZSANCj4+Pj4gQmFja3VwDQo+Pj4+ICvCoCBQcm90ZWN0aW9uKSBiaXQgcmVwcmVzZW50ZWQg
YnkgdGhlIG1hc2ssIG1hbmRhdG9yeSB0byANCj4+Pj4gZGlzYWJsZS9lbmFibGUgYmFja3VwDQo+
Pj4+ICvCoCBkb21haW4gKFJUQyByZWdpc3RlcnMpIHdyaXRlIHByb3RlY3Rpb24uDQo+Pj4NCj4+
PiBJdCdzIGZpbmUgdG8gYWRkIHRoaXMsIGJ1dCB5b3UgYXJlIGJyZWFraW5nIGNvbXBhdGliaWxp
dHkgaW4gdGhlIGRyaXZlcg0KPj4+IHdpdGggZXhpc3RpbmcgRFRCcyBieSByZXF1aXJpbmcgdGhl
c2UgbmV3IGZpZWxkcy4NCj4+Pg0KPj4NCj4+IEknbSBmaW5lIHdpdGggdGhhdCBjaGFuZ2UgYnV0
IEkgd291bGQgbGlrZSBjb25maXJtYXRpb24gdGhhdCB0aGlzIGhhcw0KPj4gYmVlbiB3ZWxsIHRo
b3VnaHQuIE1heWJlIE1heGltZSBvciBBbGV4YW5kcmUgY291bGQgZ2l2ZSB0aGVpciBhY2suDQo+
Pg0KPiANCj4gSXQncyBhIGdvb2QgdGhpbmcgdG8gcmVtb3ZlIFBXUiByZWdpc3RlcnMgaW5mb3Jt
YXRpb24gZnJvbSBSVEMgZHJpdmVyLiANCj4gTXkgb25seSBjb25jZXJuIHdhcyB0aGUgY29tcGF0
aWJpbGl0eSB3aXRoIG9sZCBEVCBidXQgd2UgY2FuIGFjY2VwdCBpdC4gDQo+IEluZGVlZCwgS2Vy
bmVsIHdpbGwgY29udGludWUgdG8gYm9vdCBmaW5lLCBvbmx5IFJUQyB3aWxsIG5vdCBwcm9iZSBp
ZiB3ZSANCj4gdXNlIG9sZCBEVC4NCj4gDQo+IEFja2VkLWJ5OiBBbGV4YW5kcmUgVE9SR1VFIDxh
bGV4YW5kcmUudG9yZ3VlQHN0LmNvbT4NCj4gDQo+IFJlZ2FyZHMNCj4gYWxleA0KDQpJIGFtIGdv
aW5nIHRvIHNlbmQgYSBzZXJpZXMgdG8gdXBkYXRlIHN0LHN5c2NmZyBwcm9wZXJ0eSBpbiANCnN0
bTMyZjQyOS9zdG0zMmY3NDYvc3RtMzJoNzQzIFJUQyBub2RlLg0KDQpUaGFua3MsDQpBbWVsaWU=
