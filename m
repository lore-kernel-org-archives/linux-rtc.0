Return-Path: <rtc-linux+bncBDS7HNEFSALRBQMTQKXAKGQEICEEITY@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id fj7si37210wib.3.2015.08.04.02.45.36
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 02:45:36 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 00/15] rtc: rx8025: cleanup
Date: Tue,  4 Aug 2015 11:45:19 +0200
Message-Id: <1438681534-12027-1-git-send-email-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

This series is a cleanup for the rx8025 driver in order to prepare it for the
inclusion of the support of new models.

Alexandre Belloni (15):
  rtc: rx8025: remove useless headers and reorder them
  rtc: rx8025: Convert to threaded IRQ
  rtc: rx8025: switch to managed irq allocation
  rtc: rx8025: remove useless probe error message
  rtc: rx8025: use BIT()
  rtc: rx8025: only handle dates between 2000 and 2099
  rtc: rx8025: fix transfer mode
  rtc: rx8025: don't reset the time
  rtc: rx8025: cleanup accessors
  rtc: rx8025: continue without alarm when irq request fails
  rtc: rx8025: fix rx8025_init_client()
  rtc: rx8025: reset validity when setting time
  rtc: rx8025: remove useless initialization
  rtc: rx8025: fix RX8025_BIT_CTRL2_CTFG initialization
  rtc: rx8025: check time validity when necessary

 drivers/rtc/rtc-rx8025.c | 272 ++++++++++++++++++-----------------------------
 1 file changed, 105 insertions(+), 167 deletions(-)

-- 
2.1.4

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
