Return-Path: <rtc-linux+bncBDS7HNEFSALRBYMC5WZAKGQELXE6X2I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d185si511988wmf.0.2015.11.29.10.18.09
        for <rtc-linux@googlegroups.com>;
        Sun, 29 Nov 2015 10:18:09 -0800 (PST)
Date: Sun, 29 Nov 2015 19:18:08 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [GIT PULL] RTC fixes for 4.4
Message-ID: <20151129181808.GA20767@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Linus,

Here are two fixes for the ds1307 driver. I don't expect much more for
this cycle.

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.4-2

for you to fetch changes up to 3abb1ada21a4fb5b2920457a2e5c8483abb09a45:

  rtc: ds1307: fix alarm reading at probe time (2015-11-26 18:11:26 +0100)

----------------------------------------------------------------
RTC fixes for 4.4

Two fixes for the ds1307 alarm and wakeup.

----------------------------------------------------------------
Felipe Balbi (1):
      rtc: ds1307: fix kernel splat due to wakeup irq handling

Simon Guinot (1):
      rtc: ds1307: fix alarm reading at probe time

 arch/arm/boot/dts/am57xx-beagle-x15.dts |  1 +
 drivers/rtc/rtc-ds1307.c                | 44 ++++++---------------------------
 2 files changed, 9 insertions(+), 36 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
