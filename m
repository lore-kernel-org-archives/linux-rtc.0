Return-Path: <rtc-linux+bncBCZ4DZNV3IDBBS7LXSVQKGQEYWW3E6Q@googlegroups.com>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de. [212.40.185.80])
        by gmr-mx.google.com with ESMTP id ec7si93051wib.3.2015.06.03.10.13.47
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Jun 2015 10:13:47 -0700 (PDT)
Message-ID: <556F35C9.4090208@metafoo.de>
Date: Wed, 03 Jun 2015 19:13:45 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Octavian Purdila <octavian.purdila@intel.com>
CC: Linus Walleij <linus.walleij@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/2] change "client->irq >= 0" to "client->irq
 > 0"
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com> <20150603110241.GK1715@piout.net>
In-Reply-To: <20150603110241.GK1715@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 06/03/2015 01:02 PM, Alexandre Belloni wrote:
> On 03/06/2015 at 00:34:11 +0300, Octavian Purdila wrote :
>> This fixes an issue introduces by commit dab472eb931b ("i2c / ACPI:
>> Use 0 to indicate that device does not have interrupt assigned") where
>> drivers will try to request IRQ 0 when no GpioInt is defined in ACPI.
>>
>> The same issue occurs when the device is instantiated via device tree
>> with no IRQ, or from the i2c sysfs interface, even before the patch
>> above.
>>
>> Linus, since the commit above was already merged in the GPIO tree,
>> should these fixes be merged also via the GPIO tree (with ACKs from
>> the others subsystem maintainers)?
>>
>
> Side question, has it been considered that IRQ 0 is valid on some
> platform and that means i2c devices will not be able to be wired to that
> IRQ anymore? Though, I don't think there are any existing design that
> does so.

If IRQ 0 is valid, that's a bug. IRQ 0 has been an invalid IRQ number in the 
global IRQ namespace for a while now. Though architectures are allowed to 
have a valid IRQ 0, but it may only be used inside the architecture code 
itself and must not be used for IRQs that are potentially be used by drivers.

- Lars

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
