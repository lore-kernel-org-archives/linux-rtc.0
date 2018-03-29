Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:8112
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbeC2AMU (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 28 Mar 2018 20:12:20 -0400
From: Trent Piepho <tpiepho@impinj.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>
CC: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
Date: Thu, 29 Mar 2018 00:12:18 +0000
Message-ID: <1522282337.10662.268.camel@impinj.com>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
In-Reply-To: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

T24gV2VkLCAyMDE4LTAzLTI4IGF0IDIwOjE0ICswMTAwLCBCcnlhbiBPJ0Rvbm9naHVlIHdyb3Rl
Og0KPiBjb21taXQgMTc5YTUwMmY4YzQ2ICgicnRjOiBzbnZzOiBhZGQgRnJlZXNjYWxlIHJ0Yy1z
bnZzIGRyaXZlciIpIGludHJvZHVjZXMNCj4gdGhlIFNOVlMgUlRDIGRyaXZlciB3aXRoIGEgZnVu
Y3Rpb24gc252c19ydGNfZW5hYmxlKCkuDQo+IA0KPiBzbnZzX3J0Y19lbmFibGUoKSBjYW4gcmV0
dXJuIGFuIGVycm9yIG9uIHRoZSBlbmFibGUgcGF0aCBob3dldmVyIHRoaXMNCj4gZHJpdmVyIGRv
ZXMgbm90IGN1cnJlbnRseSB0cmFwIHRoYXQgZmFpbHVyZSBvbiB0aGUgcHJvYmUoKSBwYXRoIGFu
ZA0KPiBjb25zZXF1ZW50bHkgaWYgZW5hYmxpbmcgdGhlIFJUQyBmYWlscyB3ZSBlbmNvdW50ZXIg
YSBsYXRlciBlcnJvciBzcGlubmluZw0KPiBmb3JldmVyIGluIHJ0Y193cml0ZV9zeW5jX2xwKCku
DQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIGJ5IHBhcnNpbmcgdGhlIHJlc3VsdCBvZiBydGNfd3Jp
dGVfc3luY19scCgpIGFuZA0KPiBwcm9wYWdhdGluZyBib3RoIGluIHRoZSBwcm9iZSBhbmQgZWxz
ZXdoZXJlLiBJZiB0aGUgUlRDIGRvZXNuJ3Qgc3RhcnQgd2UNCj4gZG9uJ3QgcHJvY2VlZCBsb2Fk
aW5nIHRoZSBkcml2ZXIgYW5kIGRvbid0IGdldCBpbnRvIHRoaXMgbG9vcCBtZXNzIGxhdGVyDQo+
IG9uLg0KPiANCg0KSSBzZW50IGEgcGF0Y2ggYSBjb3VwbGUgd2Vla3MgYWdvIHRoYXQgYWRkcmVz
c2VkIGEgc2ltaWxhciBpc3N1ZSwgc2VlDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Bh
dGNoLzg4NzA5MC8NCg0KRG9lcyB0aGlzIGFsc28gZml4IHRoZSBwcm9ibGVtIHlvdSBzZWU/DQoN
CkkgdGhpbmsgd2hhdCB5b3UndmUgZG9uZSB3aWxsIHByZXZlbnQgdGhlIGRyaXZlciBmcm9tIGxv
YWRpbmcgaWYgdGhlDQpjbG9jayBpcyBub3Qgd29ya2luZywgYnV0IGlmIHRoZSBjbG9jayBkb2Vz
IG5vdCB0aWNrIHByb3Blcmx5IGFmdGVyDQpsb2FkaW5nLCB0aGVyZSBhcmUgc3RpbGwgcG9pbnRz
IChzbnZzX3J0Y19yZWFkX3RpbWUgZm9yIG9uZSkgdGhhdCB3aWxsDQpsb2NrIHVwIGluIHRoZSBr
ZXJuZWwu
