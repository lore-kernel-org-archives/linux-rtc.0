Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43598 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753962AbeEYJXr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 25 May 2018 05:23:47 -0400
Received: by mail-wr0-f175.google.com with SMTP id r13-v6so7981956wrj.10
        for <linux-rtc@vger.kernel.org>; Fri, 25 May 2018 02:23:47 -0700 (PDT)
Message-ID: <fa7eee0178fe888859730e7ce41e8e8af512f685.camel@gmail.com>
Subject: rtc_cmos 00:01: nvmem registration failed
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: linux-rtc@vger.kernel.org
Cc: alexandre.belloni@bootlin.com
Date: Fri, 25 May 2018 11:23:43 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

I've used kernel 4.17 rc5 and now using rc6 on Fedora 28 on a Dell XPS
13 9370 machine. Since upgrading to this kernel, I get the following
messages in the journal:

máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: RTC can wake from S4
máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: registered as rtc0
máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: nvmem registration failed
máj 25 08:54:06 timur-xps kernel: rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs

The "nvmem registration failed" is highlighted red in the journal, and also shows up on every boot.

This where the error message comes from:
https://github.com/torvalds/linux/blob/master/drivers/rtc/rtc-cmos.c#L818
And this is the commit that introduced it:
https://github.com/torvalds/linux/commit/8b5b7958fd1cac54bdca62ec5552c6be0b38def4#diff-4dcdf420d40078042c28f0f3d8d6535c

The error message doesn't give any indication about why it failed.
How can I help diagnose the what the problem is?

Created a bugzilla entry, to give better visibility:
https://bugzilla.kernel.org/show_bug.cgi?id=199801
Someone already reported it against Fedora:
https://bugzilla.redhat.com/show_bug.cgi?id=1568276
In the bug report the user says he uses a Msi z370 pc pro motherboard,
so I assume the problem is not specific to my machine.

Thanks & best regards,
Tim

ps. I'm not registered to the mailing list, please CC me on replies.
