Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17670 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751858AbeEQKEh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 17 May 2018 06:04:37 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rtc: stm32: add stm32mp1 rtc support
Date: Thu, 17 May 2018 10:03:41 +0000
Message-ID: <18a9abfc-a67c-509e-7f9b-af666ada52ae@st.com>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
 <1525880770-22263-4-git-send-email-amelie.delaunay@st.com>
 <20180516203240.GB24496@piout.net>
In-Reply-To: <20180516203240.GB24496@piout.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

T24gMDUvMTYvMjAxOCAxMDozMiBQTSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IE9uIDA5
LzA1LzIwMTggMTc6NDY6MTArMDIwMCwgQW1lbGllIERlbGF1bmF5IHdyb3RlOg0KPj4gICBzdHJ1
Y3Qgc3RtMzJfcnRjX3JlZ2lzdGVycyB7DQo+PiBAQCAtODYsNiArOTgsOSBAQCBzdHJ1Y3Qgc3Rt
MzJfcnRjX3JlZ2lzdGVycyB7DQo+PiAgIAl1OCBwcmVyOw0KPj4gICAJdTggYWxybWFyOw0KPj4g
ICAJdTggd3ByOw0KPj4gKwl1OCBzcjsNCj4+ICsJdTggc2NyOw0KPj4gKwl1MTYgdmVycjsNCj4g
DQo+IEFsbCB0aG9zZSBvZmZzZXRzIHNob3VsZCBwcm9iYWJseSBiZSB1MTYgb3IgdTMyLi4uDQo+
DQoNCk9LLCB0aG9zZSBvZmZzZXRzIHdpbGwgYmUgYWxsIHUxNiBpbiB2MywgdGhlIG1heGltdW0g
U1RNMzIgUlRDIHJlZ2lzdGVyIA0Kb2Zmc2V0IHZhbHVlIGJlaW5nIDB4M0ZDLg0KDQo+PiArCWlm
IChyZWdzLnZlcnIgIT0gVU5ERUZfUkVHKSB7DQo+IA0KPiAuLi5lbHNlLCB0aGlzIGlzIG5vdCB3
b3JraW5nLCBhcyByZXBvcnRlZCBieSBrYnVpbGQNCj4gDQoNClllcywgaW4gdjMsIFVOREVGX1JF
RyB3aWxsIGJlIHRoZSBtYXhpbXVtIHUxNiB2YWx1ZSAoMHhGRkZGKSBpbnN0ZWFkIG9mIH4wLg0K
DQo+PiArCQl1MzIgdmVyID0gcmVhZGxfcmVsYXhlZChydGMtPmJhc2UgKyByZWdzLnZlcnIpOw0K
Pj4gKw0KPj4gKwkJZGV2X2luZm8oJnBkZXYtPmRldiwgInJlZ2lzdGVyZWQgcmV2OiVkLiVkXG4i
LA0KPj4gKwkJCSAodmVyID4+IFNUTTMyX1JUQ19WRVJSX01BSlJFVl9TSElGVCkgJiAweEYsDQo+
PiArCQkJICh2ZXIgPj4gU1RNMzJfUlRDX1ZFUlJfTUlOUkVWX1NISUZUKSAmIDB4Rik7DQo+PiAr
CX0NCj4+ICsNCj4gDQoNClRoYW5rcywNCkFtZWxpZQ==
