Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:11168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752357AbeC3W7C (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 30 Mar 2018 18:59:02 -0400
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
Date: Fri, 30 Mar 2018 22:59:00 +0000
Message-ID: <1522450739.10662.278.camel@impinj.com>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
         <1522282337.10662.268.camel@impinj.com>
         <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
In-Reply-To: <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTI5IGF0IDAyOjUzICswMTAwLCBCcnlhbiBPJ0Rvbm9naHVlIHdyb3Rl
Og0KPiBPbiAyOS8wMy8xOCAwMToxMiwgVHJlbnQgUGllcGhvIHdyb3RlOg0KPiANCj4gPiBJIHNl
bnQgYSBwYXRjaCBhIGNvdXBsZSB3ZWVrcyBhZ28gdGhhdCBhZGRyZXNzZWQgYSBzaW1pbGFyIGlz
c3VlLCBzZWUNCj4gPiBodHRwczovL25hMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNod29yay5vemxhYnMub3JnJTJGcGF0Y2glMkY4ODcw
OTAlMkYmZGF0YT0wMiU3QzAxJTdDdHBpZXBobyU0MGltcGluai5jb20lN0NiNjIyOTQwODAyZGY0
OWRlYWM0YzA4ZDU5NTE3ZThkOCU3QzZkZTcwZjBmNzM1NzQ1MjlhNDE1ZDhjYmI3ZTkzZTVlJTdD
MCU3QzElN0M2MzY1Nzg4NTIyODMzOTA3NDUmc2RhdGE9ZHMwb2ZwYlRxckhCakdBMThOMzQzY0pK
OXN5MlNUUTlaelN4SDJUVXl6RSUzRCZyZXNlcnZlZD0wDQo+ID4gDQo+ID4gRG9lcyB0aGlzIGFs
c28gZml4IHRoZSBwcm9ibGVtIHlvdSBzZWU/DQo+IA0KPiBJdCBicmVha3MgdGhlIGVuZGxlc3Mg
bG9vcCB0aGF0IGhhcHBlbnMgbGF0ZXIgb24gaW4gdGhlIFJUQyByZWFkIHBhdGguDQo+IA0KPiBU
aGlzIHBhdGNoIHRob3VnaCBpcyBhYm91dCBmaXhpbmcgdGhlIGJ1ZyB3aXRoIG5vdCBoYW5kbGlu
ZyB0aGUgZW5hYmxlIA0KPiBvZiB0aGUgc252c19ydGNfZW5hYmxlKCkgY29ycmVjdGx5LCB3aGlj
aCBpcyB3aHkgaXQgc2hvdWxkIGJlIGFwcGxpZWQuDQo+IA0KPiBUaGUgcmlnaHQgZmxvdyBpcyB0
byBoYW5kbGUgdGhlIGVycm9yIG9uIHNudnNfcnRjX2VuYWJsZSgpIGFzIHNvb24gYXMgaXQgDQo+
IGhhcHBlbnMgYXMgb3Bwb3NlZCB3YWl0IGZvciByZWFkKCkgdG8gLUVUSU1FRE9VVC4NCg0KVW5s
ZXNzIHRoZXJlIGFyZSBib2FyZHMgdGhhdCBkb24ndCBlbmFibGUgdGhlIDMya0h6IG9zY2lsbGF0
b3IgdW50aWwNCmFmdGVyIHRoZSBrZXJuZWwgZHJpdmVyIGxvYWRzLiAgSSB3YXMgY29uY2VybmVk
IGFib3V0IHRoYXQgc28gZGlkbid0DQphZGQgdGhlIGNoZWNrIGluIHByb2JlIHRvIHByZXZlbnQg
dGhlIGRyaXZlciBmcm9tIGxvYWRpbmcuICBJZiB0aGUNCnBvc3NpYmxlIGRpc3J1cHRpb24gb2Yg
dGhhdCBpcyBhY2NlcHRhYmxlLCB0aGVuIGl0IGRvZXMgc2VlbSBiZXR0ZXIgdG8NCmZhaWwgdG8g
bG9hZC4NCg0KSG93ZXZlciwgSSB0aGluayB0aGF0IGV2ZW4gaWYgdGhlIGRyaXZlciBmYWlscyB0
byBwcm9iZSBpZiB0aGVyZSBpcyBhDQp0aW1lb3V0IGF0IHByb2JlIHRpbWUsIGl0J3Mgc3RpbGwg
cG9zc2libGUgdG8gaGFuZyBsYXRlciBpZiB0aGVyZSBhcmUNCm5vdCBsaW1pdHMgdG8gdGhlIGhh
cmR3YXJlIHBvbGxpbmcgbG9vcHMsIHN1Y2ggYXMgdGhlIG9uZXMgSSBhZGRlZC4NCg0KPiA+IEkg
dGhpbmsgd2hhdCB5b3UndmUgZG9uZSB3aWxsIHByZXZlbnQgdGhlIGRyaXZlciBmcm9tIGxvYWRp
bmcgaWYgdGhlDQo+ID4gY2xvY2sgaXMgbm90IHdvcmtpbmcsIGJ1dCBpZiB0aGUgY2xvY2sgZG9l
cyBub3QgdGljayBwcm9wZXJseSBhZnRlcg0KPiA+IGxvYWRpbmcsIHRoZXJlIGFyZSBzdGlsbCBw
b2ludHMgKHNudnNfcnRjX3JlYWRfdGltZSBmb3Igb25lKSB0aGF0IHdpbGwNCj4gPiBsb2NrIHVw
IGluIHRoZSBrZXJuZWwuDQo+IA0KPiBJJ2xsIGRpZyBvdXQgeW91ciBwYXRjaCBhbmQgZ2l2ZSBp
dCBhIHJldmlldy4NCj4g
