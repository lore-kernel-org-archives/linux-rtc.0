Return-Path: <rtc-linux+bncBDKLLFXN7AKBBNVPXOVQKGQEN7FGIFI@googlegroups.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTP id xv6si34452pab.2.2015.06.03.03.32.22
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Jun 2015 03:32:22 -0700 (PDT)
Date: Wed, 3 Jun 2015 13:32:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: change "client->irq >= 0" to
 "client->irq > 0"
Message-ID: <20150603103217.GQ4057@lahna.fi.intel.com>
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
 <1433280853-3988-3-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433280853-3988-3-git-send-email-octavian.purdila@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jun 03, 2015 at 12:34:13AM +0300, Octavian Purdila wrote:
> Since commit dab472eb931b ("i2c / ACPI: Use 0 to indicate that device
> does not have interrupt assigned"), 0 is not a valid i2c client irq
> anymore, so change all driver's checks accordingly.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>

In addition to Alexandre's comments, the change itself looks good to me
so once you address them,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for taking care of this.

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
