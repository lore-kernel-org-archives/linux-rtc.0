Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42114 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754024AbeEWHYc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 23 May 2018 03:24:32 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] rtc: st-lpc: add range
Date: Wed, 23 May 2018 07:24:14 +0000
Message-ID: <8d2f6057-4d33-6b75-f01e-df06e9426d07@st.com>
References: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

SGkgQWxleGFuZHJlDQoNCk9uIDA1LzIxLzIwMTggMTA6NDkgUE0sIEFsZXhhbmRyZSBCZWxsb25p
IHdyb3RlOg0KPiBUaGUgUlRDIGhhcyBhIDY0IGJpdCBjb3VudGVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL3J0Yy9ydGMtc3QtbHBjLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3J0
Yy1zdC1scGMuYyBiL2RyaXZlcnMvcnRjL3J0Yy1zdC1scGMuYw0KPiBpbmRleCAyZjFlZjJjMjg3
NDAuLmJlZTc1Y2E3ZmY3OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ydGMvcnRjLXN0LWxwYy5j
DQo+ICsrKyBiL2RyaXZlcnMvcnRjL3J0Yy1zdC1scGMuYw0KPiBAQCAtMjU4LDYgKzI1OCw4IEBA
IHN0YXRpYyBpbnQgc3RfcnRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHJ0Yyk7DQo+ICAgDQo+ICAgCXJ0Yy0+cnRj
X2Rldi0+b3BzID0gJnN0X3J0Y19vcHM7DQo+ICsJcnRjLT5ydGNfZGV2LT5yYW5nZV9tYXggPSBV
NjRfTUFYOw0KPiArCWRvX2RpdihydGMtPnJ0Y19kZXYtPnJhbmdlX21heCwgcnRjLT5jbGtyYXRl
KTsNCj4gICANCj4gICAJcmV0ID0gcnRjX3JlZ2lzdGVyX2RldmljZShydGMtPnJ0Y19kZXYpOw0K
PiAgIAlpZiAocmV0KSB7DQo+IA0KDQpBY2tlZC1ieTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNl
LmNob3RhcmRAc3QuY29tPg0KDQpQYXRyaWNl
