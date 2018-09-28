Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:53543 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbeI1S36 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 28 Sep 2018 14:29:58 -0400
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: isl1208: access i2c client via rtc parent
Date: Fri, 28 Sep 2018 12:06:27 +0000
Message-ID: <1538136387.6162.10.camel@diehl.com>
References: <20180928114832.27383-1-Denis.Osterland@diehl.com>
         <20180928120451.GR16644@piout.net>
In-Reply-To: <20180928120451.GR16644@piout.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

QW0gRnJlaXRhZywgZGVuIDI4LjA5LjIwMTgsIDE0OjA0ICswMjAwIHNjaHJpZWIgQWxleGFu
ZHJlIEJlbGxvbmk6DQo+IEhlbGxvLA0KPsKgDQo+IE9oIHJpZ2h0LCBJIGFjdHVhbGx5IGhh
ZCB0aGF0IGJ1dCBzb21laG93LCBJIHN0YXNoZWQgdGhlIHBhdGNoIGluc3RlYWQNCj4gb2Yg
c3F1YXNoaW5nIGl0Lg0KPiANCj4gSWYgdGhhdCBpcyBmaW5lIGZvciB5b3UsIEknbGwgZm9s
ZCB0aGF0IGluIHRoZSBvcmlnaW5hbCBwYXRjaCAoSSdsbCBhZA0KPiB5b3VyIFNvQikuDQo+
IA0KPiANClNvdW5kcyBnb29kLg0KDQpSZWdhcmRzIERlbmlzDQoNCkRpZWhsIENvbm5lY3Rp
dml0eSBTb2x1dGlvbnMgR21iSA0KR2VzY2jDpGZ0c2bDvGhydW5nOiBIb3JzdCBMZW9uYmVy
Z2VyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IE7DvHJuYmVyZyAtIFJlZ2lzdGVyZ2VyaWNo
dDogQW10c2dlcmljaHQNCk7DvHJuYmVyZzogSFJCIDMyMzE1DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRGVyIEluaGFsdCBkZXIgdm9yc3Rl
aGVuZGVuIEUtTWFpbCBpc3QgbmljaHQgcmVjaHRsaWNoIGJpbmRlbmQuIERpZXNlIEUtTWFp
bCBlbnRoYWVsdCB2ZXJ0cmF1bGljaGUgdW5kL29kZXIgcmVjaHRsaWNoIGdlc2NodWV0enRl
IEluZm9ybWF0aW9uZW4uDQpJbmZvcm1pZXJlbiBTaWUgdW5zIGJpdHRlLCB3ZW5uIFNpZSBk
aWVzZSBFLU1haWwgZmFlbHNjaGxpY2hlcndlaXNlIGVyaGFsdGVuIGhhYmVuLiBCaXR0ZSBs
b2VzY2hlbiBTaWUgaW4gZGllc2VtIEZhbGwgZGllIE5hY2hyaWNodC4NCkplZGUgdW5lcmxh
dWJ0ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24sIEJla2FubnRnYWJlLCBBZW5kZXJ1bmcsIFZl
cnRlaWx1bmcgdW5kL29kZXIgUHVibGlrYXRpb24gZGllc2VyIEUtTWFpbCBpc3Qgc3RyZW5n
c3RlbnMgdW50ZXJzYWd0Lg0KVGhlIGNvbnRlbnRzIG9mIHRoZSBhYm92ZSBtZW50aW9uZWQg
ZS1tYWlsIGlzIG5vdCBsZWdhbGx5IGJpbmRpbmcuIFRoaXMgZS1tYWlsIGNvbnRhaW5zIGNv
bmZpZGVudGlhbCBhbmQvb3IgbGVnYWxseSBwcm90ZWN0ZWQgaW5mb3JtYXRpb24uIFBsZWFz
ZSBpbmZvcm0gdXMgaWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgYnkNCm1pc3Rh
a2UgYW5kIGRlbGV0ZSBpdCBpbiBzdWNoIGEgY2FzZS4gRWFjaCB1bmF1dGhvcml6ZWQgcmVw
cm9kdWN0aW9uLCBkaXNjbG9zdXJlLCBhbHRlcmF0aW9uLCBkaXN0cmlidXRpb24gYW5kL29y
IHB1YmxpY2F0aW9uIG9mIHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIA0K
