Return-Path: <rtc-linux+bncBCV6LFM5RQJRB2XYYOWQKGQEAZHIVZY@googlegroups.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com. [209.85.212.169])
        by gmr-mx.google.com with ESMTPS id cj6si884539wib.1.2015.07.23.07.38.33
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 07:38:33 -0700 (PDT)
Received: by wicgb10 with SMTP id gb10so146184707wic.1
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 07:38:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150723140516.A3C9E4314B@saturn.retrosnub.co.uk>
References: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
	<1433512783-8183-2-git-send-email-octavian.purdila@intel.com>
	<CAE1zotJ_u+ysf+HkD=4=Nv_mJ-4++SZxjKGMRkbKzYzyunLJUg@mail.gmail.com>
	<20150723140516.A3C9E4314B@saturn.retrosnub.co.uk>
Date: Thu, 23 Jul 2015 17:38:33 +0300
Message-ID: <CAE1zotJiuHsicKuPwyK_rKRY9qDyLV=nFEqJ4ATuroN924nHVg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 1/2] iio: fix drivers that consider 0 as a
 valid IRQ in client->irq
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, rtc-linux@googlegroups.com,
	lkml <linux-kernel@vger.kernel.org>
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

On Thu, Jul 23, 2015 at 5:05 PM, <jic23@jic23.retrosnub.co.uk> wrote:
>
> Octavian Purdila writes:
>>
>> On Fri, Jun 5, 2015 at 4:59 PM, Octavian Purdila
>> <octavian.purdila@intel.com> wrote:
>>>
>>> Since patch "i2c / ACPI: Use 0 to indicate that device does not have
>>> interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
>>> change all driver's checks accordingly.
>>> The same issue occurs when the device is instantiated via device tree
>>> with no IRQ, or from the i2c sysfs interface, even before the patch
>>> above.
>>> [1] http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
>>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>>
>> Hi Jonathan,
>> Does this look OK to you? If so, could you pleas ACK the patch so that
>> Linus can pick it up in its for-next branch if/when needed?
>> Thanks,
>> Tavi
>
> Hi Tavi,
> This is fine, but is there a particular rush to get it in?
> Otherwise I'll just take it through the IIO tree.
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Hi Jonathan,

Didn't mean to rush things, I haven't seen any activity on this for
some time and thought it was forgotten. I was also confused with the
status of Mika's patch, but now that I learned it was merged in 4.2,
its clear to me that this patch needs to go through the IIO tree.

Thanks,
Tavi

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
