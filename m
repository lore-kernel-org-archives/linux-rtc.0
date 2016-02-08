Return-Path: <rtc-linux+bncBD2OLRXW4ABBB24W4O2QKGQEQPTIT5Q@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id tn7si4527131pac.1.2016.02.08.09.07.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2016 09:07:54 -0800 (PST)
Message-ID: <56B8C8B4.4050207@nvidia.com>
Date: Mon, 8 Feb 2016 22:26:20 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <javier@osg.samsung.com>,
	<gregkh@linuxfoundation.org>, <a.zummo@towertech.it>,
	<cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
	<rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V4 1/6] regmap: irq: add apis to unmap the
 mapped irq
References: <1454769447-785-1-git-send-email-ldewangan@nvidia.com> <1454769447-785-2-git-send-email-ldewangan@nvidia.com> <20160208145550.GE7265@sirena.org.uk> <56B8C484.7000309@nvidia.com> <20160208165912.GK7265@sirena.org.uk>
In-Reply-To: <20160208165912.GK7265@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Adding Thomas in the discussion.

On Monday 08 February 2016 10:29 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Mon, Feb 08, 2016 at 10:08:28PM +0530, Laxman Dewangan wrote:
>> On Monday 08 February 2016 08:25 PM, Mark Brown wrote:
>>> On Sat, Feb 06, 2016 at 08:07:22PM +0530, Laxman Dewangan wrote:
>>>> Before removing irq domains, it is require to unmap all
>>>> mapped interrupt from that domain. Currently there is API
>>>> to map the interrupt on chip as regmap_irq_get_virq() for
>>>> creating mapping. Add equivalent API to dispose the mapped
>>>> irq in irq domains.
>>> This makes no sense to me.  Why would you ever want to unmap the
>>> interrupts separately to destroying the domain
>> This is the requirement from irq_domain_remove(). This is what we have in
>> irq_domain_remove():
>> kernel/irq/irqdomain.c
>> I am adding the API equivalent to regmap_irq_get_virq() to unmap virtual irq
>> here.
> This does not explain why anyone would ever want to use this interface
> (which was my question), why would anyone ever want to do this as a
> separate step?

OK, so you want to say that irq_domain_remove() should take care of 
doing unmap also?

>
>>> and why would you ever
>>> want to destroy the domain without unmapping the interrupts?
>> That's exactlly we are trying to do, unmap interrupt in client level before
>> destroying domain.
> Again, why would any client ever want to skip this step?

If above is yes then we will not need for unmap virtual irq.
So fix need to go in the irq_domain_remove() to unamp before actually 
destroying the irq domain?


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
