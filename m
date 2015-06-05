Return-Path: <rtc-linux+bncBDS7HNEFSALRB3NXY2VQKGQE7GPJMVQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k10si252947wia.1.2015.06.05.05.54.04
        for <rtc-linux@googlegroups.com>;
        Fri, 05 Jun 2015 05:54:05 -0700 (PDT)
Date: Fri, 5 Jun 2015 14:54:04 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: fix drivers that consider 0 as a
 valid IRQ in client->irq
Message-ID: <20150605125404.GI713@piout.net>
References: <1433508118-3938-1-git-send-email-octavian.purdila@intel.com>
 <1433508118-3938-3-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433508118-3938-3-git-send-email-octavian.purdila@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 05/06/2015 at 15:41:58 +0300, Octavian Purdila wrote :
> Since patch "i2c / ACPI: Use 0 to indicate that device does not have
> interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
> change all driver's checks accordingly.
> 
> The same issue occurs when the device is instantiated via device tree
> with no IRQ, or from the i2c sysfs interface, even before the patch
> above.
> 
> [1] https://lkml.org/lkml/2015/5/6/279
> 

lkml.org is not reliable and is currently losing messages. Like I
suggested, you should use the redirector at https://lkml.kernel.org/

That would be
http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>


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
