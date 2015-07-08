Return-Path: <rtc-linux+bncBAABBVOI62WAKGQEWMFQDWI@googlegroups.com>
Received: from mail.pbx.lv ([213.175.90.140])
        by gmr-mx.google.com with ESMTP id h8si108231lbd.3.2015.07.08.15.29.40
        for <rtc-linux@googlegroups.com>;
        Wed, 08 Jul 2015 15:29:40 -0700 (PDT)
To: Arnd Bergmann <arnd@arndb.de>
Subject: [rtc-linux] Re: [1/2] RTC: Add core rtc support for Gemini Soc devices
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_67088d988b0a24aeb73414770ae6e224"
Date: Thu, 09 Jul 2015 01:29:39 +0300
From: Roman Yeryomin <roman@advem.lv>
Cc: linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@openwrt.org>,
 rtc-linux@googlegroups.com, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Russell King
 <rmk+kernel@arm.linux.org.uk>, Hans Ulli Kroll <ulli.kroll@googlemail.com>
In-Reply-To: <2131951.l0j0CIttAZ@wuerfel>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2349062.9v3Zz7HPLu@wuerfel> <0701f75c1c42f74fd58845bc0ed41c38@advem.lv>
 <2131951.l0j0CIttAZ@wuerfel>
Message-ID: <f22e65faa7d86074cda27973f83d7a52@advem.lv>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--=_67088d988b0a24aeb73414770ae6e224
Content-Type: text/plain; charset=UTF-8; format=flowed

On 2015-05-08 19:08, Arnd Bergmann wrote:
> On Thursday 07 May 2015 12:03:25 Roman Yeryomin wrote:
>> On 2015-05-06 22:22, Arnd Bergmann wrote:
>> > On Wednesday 06 May 2015 19:21:21 Roman Yeryomin wrote:
>> >>
>> >> > Thanks to point that, I'll merge that one which seems clean enough:
>> >> > http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/files/drivers/rtc/rtc-gemini.c;h=587d8122b2fbb1230437eadcce4789a53aa60ee5;hb=4c637410a2a1ab45988e8ca6202554a502102039
>> >>
>> >> For 3.18 (and up) to work on gemini 160-gemini-timers.patch is vital.
>> >> Without that timers are broken and cpu is super slow.
>> >
>> > Do you know what part of the patch is the actual bug fix? We should
>> > probably
>> > merge that separately and mark it for stable backports, while the bulk
>> > of that
>> > patch seems to just rearrange code.
>> >
>> >       Arnd
>> 
>> Sorry, didn't try to extract the exact lines it but I guess it's that
>> part which touches the scheduler clock code.
>> Because without that patch sched clock runs at 100Hz instead of 25MHz.
>> I can dive into this deeper if you want, I just didn't see the need.
> 
> I think that would be helpful, yes.
> 

OK, here are the minimal changes required (see attachment). Tested on 
4.1.1
Let me know if you want me to submit it in some other way.

Regards,
Roman

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--=_67088d988b0a24aeb73414770ae6e224
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=160-gemini-timers.patch
Content-Disposition: attachment;
 filename=160-gemini-timers.patch;
 size=1986

LS0tIGEvYXJjaC9hcm0vbWFjaC1nZW1pbmkvdGltZS5jCisrKyBiL2FyY2gvYXJtL21hY2gtZ2Vt
aW5pL3RpbWUuYwpAQCAtMTUsNiArMTUsNyBAQAogI2luY2x1ZGUgPGFzbS9tYWNoL3RpbWUuaD4K
ICNpbmNsdWRlIDxsaW51eC9jbG9ja2NoaXBzLmg+CiAjaW5jbHVkZSA8bGludXgvY2xvY2tzb3Vy
Y2UuaD4KKyNpbmNsdWRlIDxsaW51eC9zY2hlZF9jbG9jay5oPgogCiAvKgogICogUmVnaXN0ZXIg
ZGVmaW5pdGlvbnMgZm9yIHRoZSB0aW1lcnMKQEAgLTM0LDkgKzM1LDE3IEBACiAjZGVmaW5lIFRJ
TUVSXzNfQ1JfRU5BQkxFCQkoMSA8PCA2KQogI2RlZmluZSBUSU1FUl8zX0NSX0NMT0NLCQkoMSA8
PCA3KQogI2RlZmluZSBUSU1FUl8zX0NSX0lOVAkJCSgxIDw8IDgpCisjZGVmaW5lIFRJTUVSXzFf
Q1JfVVBET1dOCQkoMSA8PCA5KQorI2RlZmluZSBUSU1FUl8yX0NSX1VQRE9XTgkJKDEgPDwgMTAp
CisjZGVmaW5lIFRJTUVSXzNfQ1JfVVBET1dOCQkoMSA8PCAxMSkKIAogc3RhdGljIHVuc2lnbmVk
IGludCB0aWNrX3JhdGU7CiAKK3N0YXRpYyB1NjQgbm90cmFjZSBnZW1pbmlfcmVhZF9zY2hlZF9j
bG9jayh2b2lkKQoreworCXJldHVybiByZWFkbChUSU1FUl9DT1VOVChJT19BRERSRVNTKEdFTUlO
SV9USU1FUjNfQkFTRSkpKTsKK30KKwogc3RhdGljIGludCBnZW1pbmlfdGltZXJfc2V0X25leHRf
ZXZlbnQodW5zaWduZWQgbG9uZyBjeWNsZXMsCiAJCQkJICAgICAgIHN0cnVjdCBjbG9ja19ldmVu
dF9kZXZpY2UgKmV2dCkKIHsKQEAgLTE1NSwxNCArMTY0LDE4IEBAIHZvaWQgX19pbml0IGdlbWlu
aV90aW1lcl9pbml0KHZvaWQpCiAJICovCiAJc2V0dXBfaXJxKElSUV9USU1FUjIsICZnZW1pbmlf
dGltZXJfaXJxKTsKIAotCS8qIEVuYWJsZSBhbmQgdXNlIFRJTUVSMSBhcyBjbG9jayBzb3VyY2Ug
Ki8KLQl3cml0ZWwoMHhmZmZmZmZmZiwgVElNRVJfQ09VTlQoSU9fQUREUkVTUyhHRU1JTklfVElN
RVIxX0JBU0UpKSk7Ci0Jd3JpdGVsKDB4ZmZmZmZmZmYsIFRJTUVSX0xPQUQoSU9fQUREUkVTUyhH
RU1JTklfVElNRVIxX0JBU0UpKSk7Ci0Jd3JpdGVsKFRJTUVSXzFfQ1JfRU5BQkxFLCBUSU1FUl9D
UihJT19BRERSRVNTKEdFTUlOSV9USU1FUl9CQVNFKSkpOwotCWlmIChjbG9ja3NvdXJjZV9tbWlv
X2luaXQoVElNRVJfQ09VTlQoSU9fQUREUkVTUyhHRU1JTklfVElNRVIxX0JBU0UpKSwKLQkJCQkg
ICJUSU1FUjEiLCB0aWNrX3JhdGUsIDMwMCwgMzIsCisJLyogRW5hYmxlIGFuZCB1c2UgVElNRVIz
IGFzIGNsb2NrIHNvdXJjZSAqLworCXdyaXRlbCgwLCBUSU1FUl9DT1VOVChJT19BRERSRVNTKEdF
TUlOSV9USU1FUjNfQkFTRSkpKTsKKwl3cml0ZWwoMCwgVElNRVJfTE9BRChJT19BRERSRVNTKEdF
TUlOSV9USU1FUjNfQkFTRSkpKTsKKwl3cml0ZWwoMCwgVElNRVJfTUFUQ0gxKElPX0FERFJFU1Mo
R0VNSU5JX1RJTUVSM19CQVNFKSkpOworCXdyaXRlbCgwLCBUSU1FUl9NQVRDSDIoSU9fQUREUkVT
UyhHRU1JTklfVElNRVIzX0JBU0UpKSk7CisJd3JpdGVsKFRJTUVSXzNfQ1JfRU5BQkxFIHwgVElN
RVJfM19DUl9VUERPV04sCisJCVRJTUVSX0NSKElPX0FERFJFU1MoR0VNSU5JX1RJTUVSX0JBU0Up
KSk7CisJaWYgKGNsb2Nrc291cmNlX21taW9faW5pdChUSU1FUl9DT1VOVChJT19BRERSRVNTKEdF
TUlOSV9USU1FUjNfQkFTRSkpLAorCQkJCSAgIlRJTUVSMyIsIHRpY2tfcmF0ZSwgMzAwLCAzMiwK
IAkJCQkgIGNsb2Nrc291cmNlX21taW9fcmVhZGxfdXApKQogCQlwcl9lcnIoInRpbWVyOiBmYWls
ZWQgdG8gaW5pdGlhbGl6ZSBnZW1pbmkgY2xvY2sgc291cmNlXG4iKTsKKwlzY2hlZF9jbG9ja19y
ZWdpc3RlcihnZW1pbmlfcmVhZF9zY2hlZF9jbG9jaywgMzIsIHRpY2tfcmF0ZSk7CiAKIAkvKiBD
b25maWd1cmUgYW5kIHJlZ2lzdGVyIHRoZSBjbG9ja2V2ZW50ICovCiAJY2xvY2tldmVudHNfY29u
ZmlnX2FuZF9yZWdpc3RlcigmZ2VtaW5pX2Nsb2NrZXZlbnQsIHRpY2tfcmF0ZSwK
--=_67088d988b0a24aeb73414770ae6e224--
