Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10946
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751225AbeEPXgg (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 16 May 2018 19:36:36 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc-snvs: Add timeouts to avoid kernel lockups
Date: Wed, 16 May 2018 23:36:34 +0000
Message-ID: <1526513793.30073.35.camel@impinj.com>
References: <20180316181202.14896-1-tpiepho@impinj.com>
         <1525897165.31312.111.camel@impinj.com> <20180510052557.GQ10960@piout.net>
In-Reply-To: <20180510052557.GQ10960@piout.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

T24gVGh1LCAyMDE4LTA1LTEwIGF0IDA3OjI1ICswMjAwLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90
ZToNCj4gSGksDQo+IA0KPiBPbiAwOS8wNS8yMDE4IDIwOjE5OjI2KzAwMDAsIFRyZW50IFBpZXBo
byB3cm90ZToNCj4gPiBCdW1wLg0KPiA+IA0KPiA+IEJlZW4gd2hpbGUsIG5vIHJlc3BvbnNlLg0K
PiA+IA0KPiA+IEFub3RoZXIgcGF0Y2ggZnJvbSBCcnlhbiBPJ0Rvbm9naHVlIHdlbnQgaW4gdG8g
Zml4IGEgcmVsYXRlZCBpc3N1ZSwgYnV0DQo+ID4gSSBiZWxpZXZlIHRoaXMgcGF0Y2ggc3RpbGwg
Zml4ZXMgYW5vdGhlciBidWcuDQo+ID4gDQo+IA0KPiBPbiBBcHJpbCAyNiwgMjAxOCwgSSd2ZSBh
c2tlZCB3aGV0aGVyIHlvdSBjb3VsZCByZWJhc2VkIG9uIHRvcCBvZg0KPiBydGMtbmV4dC4NCj4g
DQoNClNvcnJ5LCBkaWRuJ3QgZ2V0IHRoYXQgZW1haWwgYW5kIHNvbWVob3cgSSBkaWRuJ3Qgc2Vl
IHRoZSBjb21tZW50IG9uIA0KcGF0Y2h3b3JrLiAgV2lsbCByZXNlbmQuICBEb24ndCB0aGluayBh
bnkgY29kZSBjaGFuZ2VkIGJ1dCBJJ2xsIGFtZW5kDQp0aGUgY29tbWl0IG1lc3NhZ2Uu
