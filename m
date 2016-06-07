Return-Path: <rtc-linux+bncBDEPXWF5QYCBBSGL3O5AKGQEWVSWCCQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com. [2607:f8b0:4001:c0b::243])
        by gmr-mx.google.com with ESMTPS id f206si1757485ita.0.2016.06.07.08.18.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jun 2016 08:18:31 -0700 (PDT)
Received: by mail-it0-x243.google.com with SMTP id r205so8684828itd.1
        for <rtc-linux@googlegroups.com>; Tue, 07 Jun 2016 08:18:31 -0700 (PDT)
MIME-Version: 1.0
From: David Binderman <linuxdev.baldrick@gmail.com>
Date: Tue, 7 Jun 2016 16:18:31 +0100
Message-ID: <CAMzoamZ64+P0Np6WQj-8JYhCw+zXdG-VQ7g2-q80fSS2cq+xyQ@mail.gmail.com>
Subject: [rtc-linux] linux-4.7-rc2/drivers/rtc/rtc-ds1685.c: 2 * bad if test ?
To: kumba@gentoo.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, dcb314@hotmail.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello there,

1.

linux-4.7-rc2/drivers/rtc/rtc-ds1685.c:392]: (style) Redundant
condition: If '!(mday >= 1)', the comparison 'mday <= 31' is always
true.

Source code is

   if (!(mday >= 1) && (mday <= 31))

Maybe better code

   if (!((mday >= 1) && (mday <= 31)))

2.

linux-4.7-rc2/drivers/rtc/rtc-ds1685.c:464]: (style) Redundant
condition: If '!(mday >= 1)', the comparison 'mday <= 31' is always
true.

Duplicate. Also in the same file:

[drivers/rtc/rtc-ds1685.c:265]: (style) Variable 'ctrlb' is assigned a
value that is never used.
[drivers/rtc/rtc-ds1685.c:812]: (style) Variable 'ctrlc' is assigned a
value that is never used.


Regards

David Binderman

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
