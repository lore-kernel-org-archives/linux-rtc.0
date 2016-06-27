Return-Path: <rtc-linux+bncBCEPJZEDQIBBBMX3YS5QKGQEOXVP2IQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from rainbowdash.ducie.codethink.co.uk (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by gmr-mx.google.com with ESMTPS id a186si117708wma.1.2016.06.27.07.52.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jun 2016 07:52:33 -0700 (PDT)
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk,
	rtc-linux@googlegroups.com,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	devicetree@vger.kernel.org
Cc: robh+dt@kernel.org,
	frowand.list@gmail.com,
	linux-amlogic@lists.infradead.org
Subject: [rtc-linux] RTC support for AMlogic devies
Date: Mon, 27 Jun 2016 15:52:11 +0100
Message-Id: <1467039135-26588-1-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This series is support for the RTC block on some of the AMLogic
Meson ARM SoCs.

The first patch is the driver, followed by device-tree patches
and enablement for the ODRoid-C1 (where it has been tested)

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
