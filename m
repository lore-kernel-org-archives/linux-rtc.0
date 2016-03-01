Return-Path: <rtc-linux+bncBDEKVJM7XAHRBIUV263AKGQEEVHA4OA@googlegroups.com>
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.24])
        by gmr-mx.google.com with ESMTPS id c140si5469wmh.1.2016.03.01.09.00.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 09:00:18 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Kyle McMartin <kyle@mcmartin.ca>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [rtc-linux] [PATCH 0/6] rtc: generic: follow up for COMPILE_TEST
Date: Tue,  1 Mar 2016 17:59:56 +0100
Message-Id: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Today's linux-next kernel allowed building the rtc-generic
driver (and most other rtc drivers) on all architectures,
but this caused some errors on architectures without asm/rtc.h.

This series reworks that driver to avoid the dependency,
and simplifies all four implementations. My first approach
was to split the driver into four separate drivers, but
that didn't feel right when three of them have their own
multiplexors.

The first five patches can be applied independent of one other,
while patch 6 is optional and can be applied when all others
are merged. Alternatively, they can all go in through the
rtc tree. I compile-tested only the powerpc and sh targets for
which I happened to have cross-compilers installed.

	Arnd

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
