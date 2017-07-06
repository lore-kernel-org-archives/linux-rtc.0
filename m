Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:53548 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753246AbdGFTQT (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 6 Jul 2017 15:16:19 -0400
To: rtc <linux-rtc@vger.kernel.org>
References: <S1752256AbdGFSzp/20170706185546Z+86@vger.kernel.org>
From: elseifthen@gmx.com
Subject: Hardware specific rtc regression in v4.4.76
Message-ID: <5c2ebf93-e45b-bc2d-e13b-618fdc12b3f3@gmx.com>
Date: Thu, 6 Jul 2017 15:16:11 -0400
MIME-Version: 1.0
In-Reply-To: <S1752256AbdGFSzp/20170706185546Z+86@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


Hello all,

There appears to be a hardware specific rtc regression in v4.4.76.

Introduced in v4.4.52 by:

commit f0414c1f8bb7a4e69064296f460773170c5435ac
Author: Colin Ian King <colin.king@canonical.com>
Date:   Mon May 16 17:22:54 2016 +0100

    rtc: interface: ignore expired timers when enqueuing new timers
    
    commit 2b2f5ff00f63847d95adad6289bd8b05f5983dd5 upstream.

 8< ---

The problem does not appear to be in v4.9.x kernels.

Maybe v4.4.76 is missing one of these?
http://marc.info/?l=linux-rtc&m=149489307123605&w=2
Which also includes the commit in question.

See this thread for more details:
https://www.linuxquestions.org/questions/slackware-14/slow-hwclock-systohc-on-reboot-shutdown-4175609040/

Note: I am not the one having this issue. I'm only reporting it, so any
questions would need to be asked in the above thread. Or perhaps the
person with the problem will follow this email thread. I will post a
link to it for them.
