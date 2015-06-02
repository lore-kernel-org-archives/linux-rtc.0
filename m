Return-Path: <rtc-linux+bncBCV6LFM5RQJRBZWCXCVQKGQESUVSIGA@googlegroups.com>
MIME-Version: 1.0
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTP id 5si2019193pdt.0.2015.06.02.14.34.30
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 14:34:30 -0700 (PDT)
From: Octavian Purdila <octavian.purdila@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [rtc-linux] [PATCH 0/2] change "client->irq >= 0" to "client->irq > 0"
Date: Wed,  3 Jun 2015 00:34:11 +0300
Message-Id: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
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

This fixes an issue introduces by commit dab472eb931b ("i2c / ACPI:
Use 0 to indicate that device does not have interrupt assigned") where
drivers will try to request IRQ 0 when no GpioInt is defined in ACPI.

The same issue occurs when the device is instantiated via device tree
with no IRQ, or from the i2c sysfs interface, even before the patch
above.

Linus, since the commit above was already merged in the GPIO tree,
should these fixes be merged also via the GPIO tree (with ACKs from
the others subsystem maintainers)?

Octavian Purdila (2):
  iio: change "client->irq >= 0" to "client->irq > 0"
  rtc: change "client->irq >= 0" to "client->irq > 0"

 drivers/iio/accel/bmc150-accel.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c   | 2 +-
 drivers/iio/accel/mma9553.c      | 2 +-
 drivers/iio/imu/kmx61.c          | 8 ++++----
 drivers/rtc/rtc-ds1374.c         | 4 ++--
 drivers/rtc/rtc-ds3232.c         | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1

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
