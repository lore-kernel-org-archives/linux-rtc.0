Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:46478 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJDQLQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 4 Oct 2017 12:11:16 -0400
Received: by mail-qk0-f169.google.com with SMTP id k123so8479824qke.3
        for <linux-rtc@vger.kernel.org>; Wed, 04 Oct 2017 09:11:16 -0700 (PDT)
MIME-Version: 1.0
From: Gabriel Beddingfield <gabe@nestlabs.com>
Date: Wed, 4 Oct 2017 09:11:13 -0700
Message-ID: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
Subject: Extreme time jitter with suspend/resume cycles
To: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Cc: Guy Erb <guy@nestlabs.com>, hharte@nestlabs.com
Content-Type: multipart/mixed; boundary="001a11479fea6841c5055abadb78"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

--001a11479fea6841c5055abadb78
Content-Type: text/plain; charset="UTF-8"

TL;DR: the "delta_delta" hack[1 and 2] in kernel/time/timekeeping.c
and drivers/rtc/class.c undermines the NTP system. It's not
appropriate to use if sub-second precision is available. I've attached
a patch to resolve this... please let me know the ways you hate it.
:-)

Hello Kernel Timekeeping Maintainers,

We have been developing a device that has very a very aggressive power
policy, doing suspend/resume cycles a few times a minute ("echo mem >
/sys/power/state"). In doing so, we found that the system time
experiences a lot of jitter (compared to, say, an NTP server). It was
not uncommon for us to see time corrections of 1s to 4s on a regular
basis. This didn't happen when the device stayed awake, only when it
was allowed to do suspend/resume.

We found that the problem is an interaction between the NTP code and
what I call the "delta_delta hack." (see [1] and [2]) This code
allocates a static variable in a function that contains an offset from
the system time to the persistent/rtc clock. It uses that time to
fudge the suspend timestamp so that on resume the sleep time will be
compensated. It's kind of a statistical hack that assumes things will
average out. It seems to have two main assumptions:

  1. The persistent/rtc clock has only single-second precision
  2. The system does not frequently suspend/resume.
  3. If delta_delta is less than 2 seconds, these assumptions are "true"

Because the delta_delta hack is trying to maintain an offset from the
system time to the persistent/rtc clock, any minor NTP corrections
that have occurred since the last suspend will be discarded. However,
the NTP subsystem isn't notified that this is happening -- and so it
causes some level of instability in its PLL logic.

This problem affects any device that does "frequent" suspend/resume
cycles. I.e. any battery-powered "linux" device (like Android phones).

Many ARM systems provide a "persistent clock." Most of them are backed
by a 32kHz clock that gives good precision and makes the delta_delta
hack unnecessary. However, devices that only have single-second
precision for the persistent clock and/or are forced to use the RTC
(whose API only allows for single-second precision) -- they still need
this hack.

I've attached a patch that we developed in-house. I have a feeling you
won't like it... since it pushes the responsibility on whoever
configures the kernel. It also ignores the RTC problem (which will
still affect a lot of battery-powered devices).

Please let me know what you think -- and what the right approach for
solving this would be.

Thanks,
Gabe

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/kernel/time/timekeeping.c?h=v4.13.4#n1717
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/drivers/rtc/class.c?h=v4.13.4#n76

--001a11479fea6841c5055abadb78
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-time-add-CONFIG_PERSISTENT_CLOCK_IS_LOW_PRECISION-to.patch"
Content-Disposition: attachment;
	filename="0001-time-add-CONFIG_PERSISTENT_CLOCK_IS_LOW_PRECISION-to.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j8d8cpuj0

RnJvbSBjMDNjZWNlZDlhMjEwYjQ4ZjI1NTJlN2RhZmE5MDk5ZWYyNDQ5MzcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiR2FicmllbCBNLiBCZWRkaW5nZmllbGQiIDxiZWRkaW5nZmll
bGRAbmVzdGxhYnMuY29tPgpEYXRlOiBXZWQsIDQgT2N0IDIwMTcgMDg6Mzg6NTcgLTA3MDAKU3Vi
amVjdDogW1BBVENIXSB0aW1lOiBhZGQgQ09ORklHX1BFUlNJU1RFTlRfQ0xPQ0tfSVNfTE9XX1BS
RUNJU0lPTiB0byBkaXNhYmxlCiBzdXNwZW5kL3Jlc3VtZSBoYWNrCgpTaWduZWQtb2ZmLWJ5OiBH
YWJyaWVsIE0uIEJlZGRpbmdmaWVsZCA8YmVkZGluZ2ZpZWxkQG5lc3RsYWJzLmNvbT4KU2lnbmVk
LW9mZi1ieTogR3V5IDxndXlAbmVzdGxhYnMuY29tPgotLS0KIGtlcm5lbC90aW1lL0tjb25maWcg
ICAgICAgfCAxNiArKysrKysrKysrKysrKysrCiBrZXJuZWwvdGltZS90aW1la2VlcGluZy5jIHwg
IDQgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
a2VybmVsL3RpbWUvS2NvbmZpZyBiL2tlcm5lbC90aW1lL0tjb25maWcKaW5kZXggYWMwOWJjMjll
YjA4Li4zMmQ1NDA4NmM5NmMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC90aW1lL0tjb25maWcKKysrIGIv
a2VybmVsL3RpbWUvS2NvbmZpZwpAQCAtMTQzLDUgKzE0MywyMSBAQCBjb25maWcgSElHSF9SRVNf
VElNRVJTCiAJICBoYXJkd2FyZSBpcyBub3QgY2FwYWJsZSB0aGVuIHRoaXMgb3B0aW9uIG9ubHkg
aW5jcmVhc2VzCiAJICB0aGUgc2l6ZSBvZiB0aGUga2VybmVsIGltYWdlLgogCitjb25maWcgUEVS
U0lTVEVOVF9DTE9DS19JU19MT1dfUFJFQ0lTSU9OCisJYm9vbCAiVGhlIHBlcnNpc3RlbnQgY2xv
Y2sgaGFzIG9ubHkgc2luZ2xlLXNlY29uZCBwcmVjaXNpb24iCisJZGVmYXVsdCB5CisJaGVscAor
CSAgV2hlbiBlbmFibGVkLCB0aGVuIG9uIHN1c3BlbmQvcmVzdW1lIHRoZSB0aW1la2VlcGluZyBj
b2RlIHdpbGwKKwkgIHRyeSB0byBtYWludGFpbiBhIGNvbnN0YW50IG9mZnNldCBiZXR3ZWVuIHRo
ZSBzeXN0ZW0gdGltZSBhbmQKKwkgIHRoZSBwZXJzaXN0ZW50IGNsb2NrIGFzIGEgbWVhbnMgb2Yg
Y29tcGVuc2F0aW5nIGZvciB0aGUgY29hcnNlCisJICAoKy8tIDEgc2Vjb25kKSBzbGVlcCB0aW1l
IGNhbGN1bGF0aW9uLiBIb3dldmVyLCB0aGlzIHdpbGwgZGlzY2FyZAorCSAgYW55ICJzbWFsbCIg
TlRQIGNvcnJlY3Rpb25zIHRoYXQgaGF2ZSBoYXBwZW5lZCBzaW5jZSB0aGUgbGFzdAorCSAgcmVz
dW1lLiBIb3dldmVyLCBpZiB0aGUgc3lzdGVtJ3MgcGVyc2lzdGVudCBjbG9jayBoYXMgYmV0dGVy
CisJICBwcmVjaXNpb24gKGUuZy4gYmVjYXVzZSBpdCdzIGJhY2tlZCBieSBhIDMya0h6IGNsb2Nr
KSwgdGhpcyBpcworCSAgbm90IG5lY2Vzc2FyeSBhbmQgaW50cm9kdWNlcyB1bm5lZWRlZCB0aW1l
IGppdHRlci4KKworCSAgSWYgeW91ciBwZXJzaXN0ZW50IGNsb2NrIGhhcyBvbmx5IHNpbmdsZS1z
ZWNvbmQgcHJlY2lzaW9uLCBzYXkgWS4KKwkgIElmIHlvdXIgcGVyc2lzdGVudCBjbG9jayBoYXMg
c3ViLXNlY29uZCBwcmVjaXNpb24sIHNheSBOLgorCiBlbmRtZW51CiBlbmRpZgpkaWZmIC0tZ2l0
IGEva2VybmVsL3RpbWUvdGltZWtlZXBpbmcuYyBiL2tlcm5lbC90aW1lL3RpbWVrZWVwaW5nLmMK
aW5kZXggMmNhZmI0OWFhNjVlLi5iMmM3YjQ0M2VmMzcgMTAwNjQ0Ci0tLSBhL2tlcm5lbC90aW1l
L3RpbWVrZWVwaW5nLmMKKysrIGIva2VybmVsL3RpbWUvdGltZWtlZXBpbmcuYwpAQCAtMTY5NCw4
ICsxNjk0LDEwIEBAIGludCB0aW1la2VlcGluZ19zdXNwZW5kKHZvaWQpCiB7CiAJc3RydWN0IHRp
bWVrZWVwZXIgKnRrID0gJnRrX2NvcmUudGltZWtlZXBlcjsKIAl1bnNpZ25lZCBsb25nIGZsYWdz
OworI2lmZGVmIENPTkZJR19QRVJTSVNURU5UX0NMT0NLX0lTX0xPV19QUkVDSVNJT04KIAlzdHJ1
Y3QgdGltZXNwZWM2NAkJZGVsdGEsIGRlbHRhX2RlbHRhOwogCXN0YXRpYyBzdHJ1Y3QgdGltZXNw
ZWM2NAlvbGRfZGVsdGE7CisjZW5kaWYKIAogCXJlYWRfcGVyc2lzdGVudF9jbG9jazY0KCZ0aW1l
a2VlcGluZ19zdXNwZW5kX3RpbWUpOwogCkBAIC0xNzEyLDYgKzE3MTQsNyBAQCBpbnQgdGltZWtl
ZXBpbmdfc3VzcGVuZCh2b2lkKQogCXRpbWVrZWVwaW5nX2ZvcndhcmRfbm93KHRrKTsKIAl0aW1l
a2VlcGluZ19zdXNwZW5kZWQgPSAxOwogCisjaWZkZWYgQ09ORklHX1BFUlNJU1RFTlRfQ0xPQ0tf
SVNfTE9XX1BSRUNJU0lPTgogCWlmIChwZXJzaXN0ZW50X2Nsb2NrX2V4aXN0cykgewogCQkvKgog
CQkgKiBUbyBhdm9pZCBkcmlmdCBjYXVzZWQgYnkgcmVwZWF0ZWQgc3VzcGVuZC9yZXN1bWVzLApA
QCAtMTczMyw2ICsxNzM2LDcgQEAgaW50IHRpbWVrZWVwaW5nX3N1c3BlbmQodm9pZCkKIAkJCQl0
aW1lc3BlYzY0X2FkZCh0aW1la2VlcGluZ19zdXNwZW5kX3RpbWUsIGRlbHRhX2RlbHRhKTsKIAkJ
fQogCX0KKyNlbmRpZgogCiAJdGltZWtlZXBpbmdfdXBkYXRlKHRrLCBUS19NSVJST1IpOwogCWhh
bHRfZmFzdF90aW1la2VlcGVyKHRrKTsKLS0gCjIuMTQuMi45MjAuZ2NmMGM2Nzk3OWMtZ29vZwoK
--001a11479fea6841c5055abadb78--
