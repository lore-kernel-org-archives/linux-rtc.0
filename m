Return-Path: <rtc-linux+bncBDX5ZRH7XQGRBWVF765QKGQEU72PP6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com. [2607:f8b0:400e:c03::235])
        by gmr-mx.google.com with ESMTPS id ph9si621332pac.1.2016.07.08.09.20.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2016 09:20:42 -0700 (PDT)
Received: by mail-pa0-x235.google.com with SMTP id fi15so366089pac.1
        for <rtc-linux@googlegroups.com>; Fri, 08 Jul 2016 09:20:42 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk,  linux-amlogic@lists.infradead.org,  rtc-linux@googlegroups.com,  kh@codethink.co.uk,  a.zummo@towertech.it,  narmstrong@baylibre.com,  devicetree@vger.kernel.org,  alexandre.belloni@free-electrons.com,  frowand.list@gmail.com
Subject: [rtc-linux] Re: [PATCH v3 0/2] AMLogic Meson SoC RTC driver
References: <1467748089-14718-1-git-send-email-ben.dooks@codethink.co.uk>
Date: Fri, 08 Jul 2016 09:20:40 -0700
In-Reply-To: <1467748089-14718-1-git-send-email-ben.dooks@codethink.co.uk>
	(Ben Dooks's message of "Tue, 5 Jul 2016 20:48:06 +0100")
Message-ID: <7hinwg85k7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> This series adds support for the on SoC RTC driver on the
> AMLogic Meson devices.

-ECONFUSED

In reply to this patch, there are two other "PATCH v3 0/2" replies, an
then the two patches themselves, have "PATCH n/4" subjects when one
would expect "PATCH n/2" subjects.

Might I recommend that you use 'git format-patch --cover-letter
--subject-prefix="PATCH vX"' when formatting your series.  Doing that
will take care of all the numbering for you.

Anyways, I was able to test this version with the DTs from the previous
version, and it works ok.

Can you respin one more time (including the Tested-by) so the RTC
maintainers can pick it up?

Thanks,

Kevin

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
