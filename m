Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F93CC10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 08:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBD5206C0
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 08:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sedYsK78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfDIIqb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:46:31 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39934 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfDIIqb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Apr 2019 04:46:31 -0400
Received: by mail-ot1-f49.google.com with SMTP id f10so8697815otb.6
        for <linux-rtc@vger.kernel.org>; Tue, 09 Apr 2019 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=22YjfVvCZ5NSNIIvl1t3Yr0blCBujWKeddrIzz6Mtb4=;
        b=sedYsK78xfBon28cMIzQavH70wAdY91dnPWJCVISdFQwNLXodYHS53Ax8fofGu/8q6
         fKsvgTKG8+rnDFdszRqbAbQUSd32w1WGixhPXQO1hRAHFkbXUm7M5j7skIGfRm8FO85j
         MUiFZXAu1hyNgJf/32bVtSD9jnKSwmGTBI2q0X24vvdmAdhlgLMwhiX/hhNbHAmFH5dx
         uO8truSWxsxIBFUNe/a+IRhqwq7jfEJq/xWntBGLGWw4m7/CNNmfnk/U9wnYNPprSdtu
         Tvjgj7jEFP0j0EEe56hT2asOLfYHgZxmFkIB56Qq0cU0pehDPlpUMgBIMLCPbT/VSpms
         syPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=22YjfVvCZ5NSNIIvl1t3Yr0blCBujWKeddrIzz6Mtb4=;
        b=qhJzPVTAkZokJIdKk586DStBstPG1wN36doen4YSbDjHvGdGw4rl3itLDXdzZ7QDaV
         G9kZigyeNKb8v7gLMEV2hFBqmUhrW7Ss4fjcSeoM+F24wk+RrwsMm3r/VhtWvlPoXehK
         j/ejzOBSW9IITrptfkNAj9jVX7olwHJApU50obfueklZ/GzQwXy+4EnX/glvMd3wywSr
         vt8CZN6K5VI/klS9JsSSmHdytJgcxUENAwDODTXmmTDAh2cuynL1bgkp6hWmNK9iXFqK
         J5Xe5fBRgPUdCoSc1os3v86TWkAQOtATLx63/ZC3aEyXn81NpOG89l8U1Cj4xcGG8c4j
         CiJA==
X-Gm-Message-State: APjAAAXwAzmvv5+ttCMxsJa7ldu4mfJcFb9FWx645e55WTUpuDRK8GlI
        w1B4GfibjYzpdJuxmP3MsVEk2WYT4aUVOFeqvvdGm04y5rw=
X-Google-Smtp-Source: APXvYqyNppfdsKEtAKQOP9gC33+SdY+XmpUzls3S+MNEvgtvb5ckwQbRfHdcSEQUQGGXvZdYnjvN+5Tdb4N163cnL6A=
X-Received: by 2002:a9d:5d03:: with SMTP id b3mr22261481oti.268.1554799590781;
 Tue, 09 Apr 2019 01:46:30 -0700 (PDT)
MIME-Version: 1.0
From:   Mastro Gippo <gipmad@gmail.com>
Date:   Tue, 9 Apr 2019 10:46:21 +0200
Message-ID: <CADjOgT_w8uHnoBe+i0_RJW4R2ZJM5-za0T9YPk0gPNwMUHQoHQ@mail.gmail.com>
Subject: Infinite loop on edge cases
To:     linux-rtc@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004e567e058614fd44"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

--0000000000004e567e058614fd44
Content-Type: text/plain; charset="UTF-8"

Hello, I have been testing the latest RTC drivers on an OpenWrt build
on a MTK7688 SOC and I got an infinite loop on boot that would block
the entire system.
Basically, if I don't have a RTC connected, any read would return
0xFF. That may be also be a problem of the I2C driver, that instead of
generating an error just returns that value. But this may happen in
other cases, like if we add an EEPROM or another IC with the same
address as the RTC, or the RTC IC fails in some unpredictable way.
The current implementation of that piece of code has some bad
practices that lead to infinite loops due to this error.
Since on these RTCs the byte at address 0x00 will never be 0xFF (check
the datasheet), I added a sanity check for this special case.
A better way to do this would be to add a retry counter when setting
the CH bit, but that's  an even more edge case that will probably
never happen.
The same infinite loop will happen on other RTC ICs that do a similar
check in other parts of code, but I don't have them so I can't edit
the code and test it.
The code has been tested and works; please consider merging it.
Thanks,
Best regards
Cristiano Griletti - Mastro Gippo

--0000000000004e567e058614fd44
Content-Type: application/octet-stream; 
	name="0001-Fixed-infinite-loop-if-RTC-is-broken-disconnected.patch"
Content-Disposition: attachment; 
	filename="0001-Fixed-infinite-loop-if-RTC-is-broken-disconnected.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ju9ji8qd0>
X-Attachment-Id: f_ju9ji8qd0

RnJvbSA1N2M4MWJiN2M5YzE1ZDhkMWYyOWVjMWU1ZTJjNWNkYzk4MGZiOTQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDcmlzdGlhbm8gR3JpbGV0dGkgLSBNYXN0cm8gR2lwcG8gPGdp
cG1hZEBnbWFpbC5jb20+CkRhdGU6IE1vbiwgOCBBcHIgMjAxOSAxNzoxMDowOSArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIEZpeGVkIGluZmluaXRlIGxvb3AgaWYgUlRDIGlzIGJyb2tlbi9kaXNjb25u
ZWN0ZWQKCklmIHRoZSBSVEMgSUMgaXMgbWlzc2luZyBvciB0aGVyZSdzIHNvbWUgb3RoZXIga2lu
ZCBvZiBlcnJvciBpbiB0aGUgSTJDIGJ1cyByZWFkaW5nIHdyb25nIGRhdGEsIHJlYWRpbmcgYWRk
cmVzcyAweDAwIG1heSBhbHdheXMgcmV0dXJuIDB4RkYgd2l0aG91dCByZXR1cm5pbmcgYW4gW2Vy
cl0gY29kZSBhdCBsaW5lIDE3MTAuCldoZW4gdGhpcyBoYXBwZW5zLCB3ZSBnZXQgc3R1Y2sgaW4g
YW4gaW5maW5pdGUgbG9vcCwgc3RvcHBpbmcgdGhlIGRldmljZSBmcm9tIGJvb3RpbmcgYW5kIGNv
bnRpbnVvdXNseSBwcmludGluZyB0aGlzIGVycm9yOgoicnRjLWRzMTMwNyAwLTAwNjg6IFNFVCBU
SU1FISIKSSBhZGRlZCBhIHNhbml0eSBjaGVjayBvZiB0aGUgYnl0ZSByZXR1cm5lZCBmcm9tIGFk
ZHJlc3MgMHgwMCwgYXMgaXQgY2FuIG5ldmVyIGJlIDB4RkYgaW4gbm9ybWFsIG9wZXJhdGlvbiBh
bmQgdGhhdCBjYW4gb25seSBtZWFuIHRoYXQgdGhlcmUncyBhIHJlYWQgZXJyb3IgKHNlZSBkYXRh
c2hlZXQpLgpUaGlzIGhhcyBiZWVuIHRlc3RlZCBvbmx5IHdpdGggRFMxMzA3LCBidXQgSSdtIHN1
cmUgdGhlIHNhbWUgYnVnIHdpbGwgaGFwcGVuIG9uIHRoZSBvdGhlciBkZXZpY2VzIHdoZXJlIHRo
ZXJlIGlzIGEgImdvdG8gcmVhZF9ydGM7IiAobGluZXMgMTc1NSBhbmQgMTc4OCkuIEkgZG9uJ3Qg
aGF2ZSB0aGUgaGFyZHdhcmUgdG8gdGVzdCB0aGVtIHNvIEkgZGlkbid0IHRvdWNoIHRoYXQgY29k
ZS4KLS0tCiBkcml2ZXJzL3J0Yy9ydGMtZHMxMzA3LmMgfCAxMyArKysrKysrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3J0Yy9ydGMtZHMxMzA3LmMgYi9kcml2ZXJzL3J0Yy9ydGMtZHMxMzA3LmMKaW5k
ZXggMDc1MzBmZS4uZGI1NjUzOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ydGMvcnRjLWRzMTMwNy5j
CisrKyBiL2RyaXZlcnMvcnRjL3J0Yy1kczEzMDcuYwpAQCAtMTcyNyw5ICsxNzI3LDE2IEBAIHN0
YXRpYyBpbnQgZHMxMzA3X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsCiAJY2FzZSBt
NDF0MTE6CiAJCS8qIGNsb2NrIGhhbHRlZD8gIHR1cm4gaXQgb24sIHNvIGNsb2NrIGNhbiB0aWNr
LiAqLwogCQlpZiAodG1wICYgRFMxMzA3X0JJVF9DSCkgewotCQkJcmVnbWFwX3dyaXRlKGRzMTMw
Ny0+cmVnbWFwLCBEUzEzMDdfUkVHX1NFQ1MsIDApOwotCQkJZGV2X3dhcm4oZHMxMzA3LT5kZXYs
ICJTRVQgVElNRSFcbiIpOwotCQkJZ290byByZWFkX3J0YzsKKwkJCWlmICh0bXAgPT0gMHhGRikg
eworCQkJCS8qIHJlYWQgZXJyb3I7IGF2b2lkIGxvb3AuICovCisJCQkJZGV2X2RiZyhkczEzMDct
PmRldiwgInJlYWQgZXJyb3IgRFMxMzA3X1JFR19TRUNTXG4iLCBlcnIpOworCQkJCWdvdG8gZXhp
dDsKKwkJCX0KKwkJCWVsc2UgeworCQkJCXJlZ21hcF93cml0ZShkczEzMDctPnJlZ21hcCwgRFMx
MzA3X1JFR19TRUNTLCAwKTsKKwkJCQlkZXZfd2FybihkczEzMDctPmRldiwgIlNFVCBUSU1FIVxu
Iik7CisJCQkJZ290byByZWFkX3J0YzsKKwkJCX0KIAkJfQogCQlicmVhazsKIAljYXNlIGRzXzEz
MDg6Ci0tIAoxLjguMy4xCgo=
--0000000000004e567e058614fd44--
